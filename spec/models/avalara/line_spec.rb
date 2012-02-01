# encoding: UTF-8

require 'spec_helper'

describe Avalara::Request::Line do
  let(:params) { Factory.attributes_for(:line) }
  let(:line) { Factory.build_via_new(:line) }

  context 'sets all attributes' do
    subject { line }

    its(:LineNo) { should == params[:line_no] }
    its(:DestinationCode) { should == params[:destination_code] }
    its(:OriginCode) { should == params[:origin_code] }
    its(:ItemCode) { should == params[:item_code] }
    its(:TaxCode) { should == params[:tax_code] }
    its(:CustomerUsageType) { should == params[:customer_usage_type] }
    its(:Qty) { should == params[:qty] }
    its(:Amount) { should == params[:amount] }
    its(:Discounted) { should == params[:discounted] }
    its(:TaxIncluded) { should == params[:tax_included] }
    its(:Ref1) { should == params[:ref_1] }
    its(:Ref2) { should == params[:ref_2] }
  end
end