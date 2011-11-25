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
end
