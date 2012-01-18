require 'spec_helper'

class FakeResponse
  def body
    "Bar!"
  end
end

class PaginationResponse
  def initialize(header = nil)
    @header = header
  end
  def body
    [1]
  end
  def headers
    @header || {}
  end

end

describe "Pagination" do
  describe "All the things" do 

    before(:each) do
      @connection = mock('connection')
      header = {
        "link" => '<https://api.github.com/user/repos?page=2&per_page=10>; rel="next", <https://api.github.com/user/repos?page=6&per_page=10>;
        rel="last"'
      }
      @connection.stub!(:get).and_return(PaginationResponse.new header)
    end
    subject do 
      Ghee::ResourceProxy.new(@connection, '/foo')
    end

    describe "#paginate" do

      it "adf" do
        proxy = subject.paginate :page => 1
        proxy.total.should be_nil

      end
    end
  end

  describe "No header" do

    before(:each) do
      @connection = mock('connection')
      @connection.stub!(:get).and_return(PaginationResponse.new)
    end
    subject do 
      Ghee::ResourceProxy.new(@connection, '/foo')
    end

    describe "#paginate" do
      it "should set current page" do
        proxy = subject.paginate :page => 1
        proxy.current_page.should == 1
      end
      it "should pass through #method_missing" do
        proxy = subject.paginate :page => 1
        proxy.size.should == 1
      end
      it "should set total" do
        proxy = subject.paginate :page => 1
        proxy.total.should == 1
      end

    end
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
