require 'spec_helper'

describe Ghee::API::Users do
  subject { Ghee.new(ACCESS_TOKEN) }

  describe "#user" do
    it "should return authenticated user" do
      VCR.use_cassette('user') do
        user = subject.user
        user['type'].should == 'User'
        user['email'].should_not be_nil
        user['created_at'].should_not be_nil
        user['html_url'].should include('https://github.com/')
        user['name'].should be_instance_of(String)
        user['login'].size.should > 0
      end
    end
  end

  describe "#users" do
    it "should return given user" do
      VCR.use_cassette('users') do
        user = subject.users('jonmagic')
        user['type'].should == 'User'
        user['login'].should == 'jonmagic'
      end
    end
  end
end
