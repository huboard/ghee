# encoding: UTF-8
require 'spec_helper'

describe Ghee do
  it "should have a VERSION constant" do
    Ghee.const_defined?('VERSION').should be_true
  end

  describe "#initialize" do
    it "should set up a connection" do
      gh = Ghee.new('abcd1234')
      gh.connection.should be_instance_of(Ghee::Connection)
      gh.connection.access_token.should == 'abcd1234'
    end
  end
end