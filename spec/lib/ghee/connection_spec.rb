require 'spec_helper'

describe Ghee::Connection do
  subject { Ghee::Connection.new('abcd1234') }

  describe "#initialize" do
    it "should set an instance variable for access token" do
      subject.access_token.should == 'abcd1234'
    end
  end

  describe "any request" do
    before(:each) do
      stub_request(:any, "https://api.github.com").
        with(:headers => {"Authorization" => "token abcd1234"}).
        to_return(:body => '{}', :headers => {"Content-Type" => 'application/json'})
    end

    let(:response) { subject.get('/') }

    it "should return 200" do
      response.status.should == 200
    end

    it "should parse the json response" do
      response.body.should == {}
    end
  end
end