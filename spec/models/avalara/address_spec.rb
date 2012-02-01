# encoding: UTF-8

require 'spec_helper'

describe Avalara::Address do
  let(:params) { Factory.attributes_for(:address) }
  let(:address) { Factory.build_via_new(:address) }

  context 'sets all attributes' do
    subject { address }

    its(:AddressCode) { should == params[:address_code] }
    its(:Line1) { should == params[:line_1] }
    its(:Line2) { should == params[:line_2] }
    its(:Line3) { should == params[:line_3] }
    its(:City) { should == params[:city] }
    its(:Region) { should == params[:region] }
    its(:Country) { should == params[:country] }
    its(:PostalCode) { should == params[:postal_code] }
    its(:Latitude) { should == params[:latitude] }
    its(:Longitude) { should == params[:longitude] }
    its(:TaxRegionId) { should == params[:tax_region_id] }
  end
end