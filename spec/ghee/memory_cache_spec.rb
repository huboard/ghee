require 'spec_helper'

class TestCache < Hash
    def read(key)
      if cached = self[key]
        Marshal.load(cached)
      end
    end

    def write(key, data)
      self[key] = Marshal.dump(data)
    end

    def fetch(key)
      read(key) || yield.tap { |data| write(key, data) }
    end
  end
@cache = TestCache.new

describe Ghee::Connection do 
  context "with custom cache middleware" do 
    before :all do 
      @cache = TestCache.new
      @connection =  connection =  Ghee::Connection.new(GH_AUTH) do |conn|
                conn.use FaradayMiddleware::Caching, @cache
              end

    end
    let( :connection ){@connection}
    describe "authorization request" do 
      it "should make one request only" do
        VCR.use_cassette "cached auth" do
          connection.get("/").status.should == 200
        end
        # this will throw a cassette warning if
        # it makes another request
        connection.get("/").status.should == 200

      end
    end
  end
end
