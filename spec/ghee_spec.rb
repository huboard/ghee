# encoding: UTF-8
require 'spec_helper'

describe Ghee do
  it "should have a VERSION constant" do
    Ghee.const_defined?('VERSION').should be_true
  end

  describe "#initialize" do
    context "with an access_token" do
      it "should set up a connection" do
        gh = Ghee.new(GH_AUTH)
        gh.connection.should be_instance_of(Ghee::Connection)
        gh.connection.hash.should == GH_AUTH
      end
    end

    context "without an access_token" do
      it "should set up a connection" do
        gh = Ghee.new
        gh.connection.should be_instance_of(Ghee::Connection)
        gh.connection.hash.should == {}
      end
    end
  end
end
