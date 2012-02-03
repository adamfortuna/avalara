# encoding: UTF-8

require 'spec_helper'

describe Avalara::Request::Invoice do
  let(:params) { Factory.attributes_for(:invoice) }
  let(:invoice) { Factory.build_via_new(:invoice) }

  context 'sets all attributes' do
    subject { invoice }

    its(:CustomerCode) { should == params[:customer_code] }
    its(:DocDate) { should == Avalara::Types::Date.coerce(params[:doc_date]) }
    its(:CompanyCode) { should == params[:company_code] }
    its(:Commit) { should == params[:commit] }
    its(:CustomerUsageType) { should == params[:customer_usage_type] }
    its(:Discount) { should == params[:discount] }
    its(:DocCode) { should == params[:doc_code] }
    its(:PurchaseOrderNo) { should == params[:purchase_order_no] }
    its(:ExemptionNo) { should == params[:exemption_no] }
    its(:DetailLevel) { should == params[:detail_level] }
    its(:DocType) { should == params[:doc_type] }
    its(:PaymentDate) { should == params[:payment_date] }
    its(:Lines) { should == params[:lines] }
    its(:Addresses) { should == params[:addresses] }
    its(:ReferenceCode) { should == params[:reference_code] }
  end
  
  context 'converts nested objects to json' do
    subject { invoice.to_json }
    it { should_not be_nil }
  end
end