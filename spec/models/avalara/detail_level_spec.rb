# encoding: UTF-8

require 'spec_helper'

describe Avalara::DetailLevel do
  let(:params) { Factory.attributes_for(:detail_level) }
  let(:detail_level) { Factory.build_via_new(:detail_level) }

  context 'sets all attributes' do
    subject { detail_level }

    its(:Line) { should == params[:line] }
    its(:Summary) { should == params[:summary] }
    its(:Document) { should == params[:document] }
    its(:Tax) { should == params[:tax] }
    its(:Diagnostic) { should == params[:diagnostic] }
  end
end