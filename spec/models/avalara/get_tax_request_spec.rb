# encoding: UTF-8

require 'spec_helper'

describe Avalara::GetTaxRequest do
  let(:params) { Factory.attributes_for(:get_tax_request) }
  let(:get_tax_request) { Factory.build_via_new(:get_tax_request) }

  context 'sets all attributes' do
    subject { get_tax_request }

    its(:CustomerCode) { should == params[:customer_code] }
    its(:DocDate) { should == params[:doc_date] }
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
end