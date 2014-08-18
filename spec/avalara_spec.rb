require 'spec_helper'

describe Avalara do
  before do
    # Load the credentials from an external file
    begin
      @avalara_config = YAML.load_file("#{File.dirname(__FILE__)}/avalara_config.yml")
      Avalara.password = @avalara_config['password']
      Avalara.username = @avalara_config['username']
      Avalara.endpoint = 'https://development.avalara.net/'
    rescue => e
      pending("PLEASE PROVIDE AVALARA CONFIGURATIONS TO RUN LIVE TESTS [#{e.to_s}]")
    end
  end

  describe '.geographical_tax' do
    subject { Avalara.geographical_tax('47.627935', '-122.51702', 100) } 
    
    it 'should not be nil' do
      expect(subject).to_not be_nil
    end

    it 'should have rate' do
      expect(subject.rate).to eq(0.087)
    end
  end

  describe '.get_tax' do
    let(:invoice) do
      Avalara::Request::Invoice.new({
        customer_code: 'mister.pants@bonobos.com',
        doc_date: Time.now,
        company_code: @avalara_config['company_code'],
        lines: [line],
        addresses: [address]
      })
    end

    let(:line) do
      Avalara::Request::Line.new({
        line_no: "1",
        destination_code: "1",
        origin_code: "1",
        qty: "1",
        amount: 1000
      })
    end

    let(:address) do
      Avalara::Request::Address.new({
        address_code: 1,
        line_1: '1 Central Park West',
        postal_code: '10023'
      })
    end

    subject { Avalara.get_tax(invoice) }

    it 'should not be nil' do
      expect(subject).to_not be_nil
    end

    it 'should have result_code be Success' do
      expect(subject.result_code).to eq('Success')
    end
  end
end
