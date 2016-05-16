# encoding: UTF-8

require 'spec_helper'

describe Avalara do
  maintain_contactology_configuration

  let(:configuration) { Avalara.configuration }

  describe '.configuration' do
    it 'yields a Avalara::Configuration instance' do
      Avalara.configuration do |yielded|
        yielded.should be_kind_of Avalara::Configuration
      end
    end

    it 'yields the same configuration instance across multiple calls' do
      Avalara.configuration do |config|
        Avalara.configuration do |config2|
          config.object_id.should == config2.object_id
        end
      end
    end

    it 'returns the configuration when queried' do
      Avalara.configuration do |config|
        Avalara.configuration.object_id.should == config.object_id
      end
    end

    it 'may be explicitly overridden' do
      configuration = Avalara::Configuration.new
      expect {
        Avalara.configuration = configuration
      }.to change(Avalara, :configuration).to(configuration)
    end

    it 'raises an ArgumentError when set to a non-Configuration object' do
      expect {
        Avalara.configuration = 'bad'
      }.to raise_error(ArgumentError)
    end
  end

  describe '.endpoint' do
    it 'returns the configuration endpoint' do
      Avalara.endpoint.should == configuration.endpoint
    end

    it 'overrides the configuration endpoint' do
      expect {
        Avalara.endpoint = 'https://example.local/'
      }.to change(configuration, :endpoint).to('https://example.local/')
    end
  end

  describe '.timeout' do
    it 'returns the configuration timeout' do
      configuration.timeout = 10
      Avalara.timeout.should == configuration.timeout
    end

    it 'overrides the configuration timeout' do
      expect {
        Avalara.timeout = 10
      }.to change(configuration, :timeout).to(10)
    end
  end

  describe '.open_timeout' do
    it 'returns the configuration timeout' do
      configuration.open_timeout = 10
      Avalara.open_timeout.should == configuration.open_timeout
    end

    it 'overrides the configuration open_timeout' do
      expect {
        Avalara.open_timeout = 10
      }.to change(configuration, :open_timeout).to(10)
    end
  end

  describe '.read_timeout' do
    it 'returns the configuration timeout' do
      configuration.read_timeout = 10
      Avalara.read_timeout.should == configuration.read_timeout
    end

    it 'overrides the configuration timeout' do
      expect {
        Avalara.read_timeout = 10
      }.to change(configuration, :read_timeout).to(10)
    end
  end

  describe '.username' do
    it 'returns the configuration username' do
      configuration.username = 'username'
      Avalara.username.should == configuration.username
    end

    it 'overrides the configuration username' do
      expect {
        Avalara.username = 'username'
      }.to change(configuration, :username).to('username')
    end
  end

  describe '.password' do
    it 'returns the configuration password' do
      configuration.password = 'password'
      Avalara.password.should == configuration.password
    end

    it 'overrides the configuration password' do
      expect {
        Avalara.password = 'password'
      }.to change(configuration, :password).to('password')
    end
  end

  describe '.version' do
    it 'returns the configuration version' do
      configuration.version = 'version'
      Avalara.version.should == configuration.version
    end

    it 'overrides the configuration version' do
      expect {
        Avalara.version = 'version'
      }.to change(configuration, :version).to('version')
    end
  end

  describe '.get_tax' do
    let(:doc_date) { Date.parse("January 1, 2012") }
    let(:invoice) { Factory.build_via_new(:invoice, doc_date: doc_date) }
    let(:request) { Avalara.get_tax(invoice) }
    subject { request }

    context 'failure' do
      let(:invoice) { Factory.build_via_new(:invoice, customer_code: nil) }
      use_vcr_cassette 'get_tax/failure'

      it 'rasises an error' do
        expect { subject }.to raise_error(Avalara::ApiError)
      end

      context 'the returned error' do
        subject do
          begin
            request
          rescue Avalara::ApiError => e
            e.message.messages.first
          end
        end

        its(:details) { should == "This value must be specified." }
        its(:refers_to) { should == "CustomerCode" }
        its(:severity) { should == "Error" }
        its(:source) { should == "Avalara.AvaTax.Services" }
        its(:summary) { should == "CustomerCode is required." }
      end
    end

    context 'with a timeout' do

      before do
        WebMock.allow_net_connect!
        Avalara.timeout = 1
        Avalara.endpoint = "http://10.255.255.1"
      end

      it 'raises an avalara timeout error' do
        expect { subject }.to raise_error(Avalara::TimeoutError)
      end
    end

    context 'with an open timeout' do

      before do
        WebMock.allow_net_connect!
        Avalara.open_timeout = 1
        Avalara.endpoint = "http://10.255.255.1"
      end

      it 'raises an avalara timeout error' do
        expect { subject }.to raise_error(Avalara::TimeoutError)
      end
    end

    context 'with a read timeout' do
      let(:dummy) { TimeoutServer.new }

      before(:all) do
        dummy.listen(TimeoutServer::CONFIG[:BindAddress], TimeoutServer::CONFIG[:Port])
        Thread.new { dummy.start }
      end

      before do
        WebMock.allow_net_connect!
        Avalara.read_timeout = 1
        Avalara.endpoint = dummy.endpoint
      end

      after(:all) do
        dummy.shutdown
      end

      it 'raises an avalara timeout error' do
        expect { subject }.to raise_error(Avalara::TimeoutError)
      end
    end

    context 'on timeout' do
      it 'raises an avalara timeout error' do
        Avalara::API.should_receive(:post).and_raise(Timeout::Error)
        expect { subject }.to raise_error(Avalara::TimeoutError)
      end
    end

    context 'success' do
      use_vcr_cassette 'get_tax/success'

      it { should be_kind_of Avalara::Response::Invoice }

      its(:doc_code) { should_not be_nil }
      its(:doc_date) { should == "2012-01-01" }
      its(:result_code) { should == "Success" }
      its(:tax_date) { should_not be_nil }
      its(:timestamp) { should_not be_nil }
      its(:total_amount) { should == "10" }
      its(:total_discount) { should == "0" }
      its(:total_exemption) { should == "10" }
      its(:total_tax) { should == "0" }
      its(:total_tax_calculated) { should == "0" }

      it 'returns 1 tax line' do
        subject.tax_lines.length.should == 1
      end

      it 'returns 1 tax address' do
        subject.tax_addresses.length.should == 1
      end

      context 'the returned tax line' do
        let(:tax_line) { request.tax_lines.first }
        subject { tax_line }

        its(:line_no) { should == "1" }
        its(:tax_code) { should == "P0000000" }
        its(:taxability) { should == "true" }
        its(:taxable) { should == "0" }
        its(:rate) { should == "0" }
        its(:tax) { should == "0" }
        its(:discount) { should == "0" }
        its(:tax_calculated) { should == "0" }
        its(:exemption) { should == "10" }

        it 'returns 1 tax detail' do
          subject.tax_details.length.should == 1
        end

        context 'the returned tax detail' do
          subject { tax_line.tax_details.first }

          its(:taxable) { should == "0" }
          its(:rate) { should == "0" }
          its(:tax) { should == "0" }
          its(:region) { should == "WA" }
          its(:country) { should == "US" }
          its(:juris_type) { should == "State" }
          its(:juris_name) { should == "WASHINGTON" }
          its(:tax_name) { should == "WA STATE TAX" }
        end
      end
    end
  end

  describe ".validate_address" do
    let(:address) { {
      Line1: "122 Hudson St",
      City: "New York",
      Region: "NY",
      Country: "US",
    } }

    def request(address)
      Avalara.validate_address(address)
    rescue Avalara::ApiError => e
      e
    end

    context "on success" do

      context "and an ambiguous city" do
        use_vcr_cassette "validate_address/success_ambiguous"

        before do
          address[:City] = "NY"
        end

        it "resolves the ambiguity on the city" do
          response = request(address)
          response.address.city.should eq("New York")
        end

        it "is a successful request" do
          response = request(address)
          response.result_code.should eq("Success")
        end
      end
    end

    context "with an error returned from the api" do
      use_vcr_cassette "validate_address/failure"

      before do
        address[:City] = "Miami"
      end

      it "raises an error" do
        expect { Avalara.validate_address(address) }.to raise_error(Avalara::ApiError)
      end

      it "returns messages with details" do
        response = request(address)
        response.message.messages.length.should == 2

        errors = response.message.messages
        city_error = errors[0]
        city_error.refers_to.should == "Address.City"
        city_error.summary.should match(/city could not be determined/)
        city_error.severity.should == "Error"

        address_geocoded_error = errors[1]
        address_geocoded_error.refers_to.should == "Address"
        address_geocoded_error.severity.should == "Error"
      end
    end
  end

  ## Missing VCR
  describe '.geographical_tax' do
    let(:latitude) { '47.627935' }
    let(:longitude) { '-122.51702' }
    let(:sales_amount) { 100 }

    subject { Avalara.geographical_tax(latitude, longitude, sales_amount) }

    use_vcr_cassette 'geographical_tax_no_sales'

    its(:rate) { should == 0.087 }
  end
end
