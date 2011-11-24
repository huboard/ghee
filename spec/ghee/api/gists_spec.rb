require 'spec_helper'

describe Ghee::API::Gists do
  subject { Ghee.new(ACCESS_TOKEN) }

  describe "#gists" do
    it "should return gists for authenticated user" do
      VCR.use_cassette('gists') do
        gists = subject.gists
        gists.size.should > 0
        gists.first['created_at'].should_not be_nil
        gists.first['files'].should be_instance_of(Hash)
      end
    end
  end
end