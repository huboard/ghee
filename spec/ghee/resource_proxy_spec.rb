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
class IncrementPager
  def initialize(times=2)
    @times = times
    @executed = 1
  end
  def headers
    
    return {} if @executed == @times
    @executed += 1
    {"link" => "<https://api.github.com/users/rauhryan/repos?page=#{@executed}>; rel=\"next\""}
  end
  def body
    [@executed]
  end

end

describe "Pagination" do
  describe "#all with many pages" do
    before(:each) do
      @connection = mock('connection')
      @connection.stub!(:get).and_return(IncrementPager.new 2)
    end

    subject do 
      Ghee::ResourceProxy.new(@connection, '/foo')
    end

    it "should return count of 2" do 
      subject.all.size.should == 2
    end
  end
  describe "#all with 1 page" do
    before(:each) do
      @connection = mock('connection')
      @connection.stub!(:get).and_return(IncrementPager.new 1)
    end

    subject do 
      Ghee::ResourceProxy.new(@connection, '/foo')
    end

    it "should return count of 1" do 
      subject.all.size.should == 1
    end
  end


  describe "past first page" do 

    before(:each) do
      @connection = mock('connection')
      header = {
        "link" => '<https://api.github.com/users/rauhryan/repos?page=3&per_page=5&type=private>; rel="next", <https://api.github.com/users/rauhryan/repos?page=10&per_page=5&type=private>; rel="last", <https://api.github.com/users/rauhryan/repos?page=1&per_page=5&type=private>; rel="first", <https://api.github.com/users/rauhryan/repos?page=1&per_page=5&type=private>; rel="prev"'
      }
      @connection.stub!(:get).and_return(PaginationResponse.new header)
    end

    subject do 
      Ghee::ResourceProxy.new(@connection, '/foo')
    end

    describe "#paginate" do
      before :each do
        @proxy = subject.paginate :page => 2, :per_page => 5
      end

      it "should set per_page from the link header" do
        @proxy.pagination[:next][:per_page].should == 5
      end
      
      it "should set next page to 3" do
        @proxy.pagination[:next][:page].should == 3
      end

      it "should set prev page to 1" do
        @proxy.pagination[:prev][:page].should == 1
      end

      it "should set first page to 1" do
        @proxy.pagination[:first][:page].should == 1
      end

      it "should set last page to 10" do
        @proxy.pagination[:last][:page].should == 10
      end

      it "should generate all the xxx_page methods" do
        @proxy.next_page.should == 3
        @proxy.prev_page.should == 1
        @proxy.first_page.should == 1
        @proxy.last_page.should == 10
      end
    end
  end
  describe "per_page is provided" do 

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
      before :each do
        @proxy = subject.paginate :page => 1, :per_page => 10
      end

      it "should set per_page from the link header" do
        @proxy.pagination[:next][:per_page].should == 10
      end
      
      it "should set next page to 2" do
        @proxy.pagination[:next][:page].should == 2
      end

      it "should set last page to 6" do
        @proxy.pagination[:last][:page].should == 6
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
      it "next page should be nil" do
        proxy = subject.paginate :page => 1
        proxy.next_page.should be_nil
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
