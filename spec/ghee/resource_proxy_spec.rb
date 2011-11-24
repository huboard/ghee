require 'spec_helper'

class FakeResponse
  def body
    "Bar!"
  end
end

describe Ghee::ResourceProxy do
  before(:each) do
    @connection = mock('connection')
    @connection.stub!(:get).and_return(FakeResponse.new)
  end

  subject do
    Ghee::ResourceProxy.new(@connection, '/foo')
  end

  describe "#initialize" do
    it "should set connection" do
      subject.instance_variable_get(:@connection).should == @connection
    end

    it "should set path_prefix" do
      subject.instance_variable_get(:@path_prefix).should == "/foo"
    end
  end

  describe "#method_missing" do
    it "should pass message and args to target" do
      subject.upcase.should == "BAR!"
    end
  end
end
