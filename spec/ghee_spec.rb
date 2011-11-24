# encoding: UTF-8
require 'spec_helper'

describe Ghee do
  it "should have a VERSION constant" do
    Ghee.const_defined?('VERSION').should be_true
  end

  describe "#initialize" do
    context "with an access_token" do
      it "should set up a connection" do
        gh = Ghee.new(ACCESS_TOKEN)
        gh.connection.should be_instance_of(Ghee::Connection)
        gh.connection.access_token.should == ACCESS_TOKEN
      end
    end

    context "without an access_token" do
      it "should set up a connection" do
        gh = Ghee.new
        gh.connection.should be_instance_of(Ghee::Connection)
        gh.connection.access_token.should be_nil
      end
    end
  end
end