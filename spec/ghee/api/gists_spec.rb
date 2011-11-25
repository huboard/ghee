require 'spec_helper'

describe Ghee::API::Gists do
  subject { Ghee.new(ACCESS_TOKEN) }

  def should_be_a_gist(gist)
    gist['description'].should be_instance_of(String)
    gist['url'].should include('https://api.github.com/gists/')
    gist['user']['url'].should include('https://api.github.com/users/')
    gist['created_at'].should_not be_nil
    gist['files'].should be_instance_of(Hash)
    gist['files'].size.should > 0
  end

  describe "#users" do
    describe "#gists" do
      it "should return users gists" do
        VCR.use_cassette('users(login).gists') do
          gists = subject.users('jonmagic').gists
          gists.size.should > 0
          should_be_a_gist(gists.first)
        end
      end
    end
  end

  describe "#gists" do
    context "with gist id" do
      it "should return single gist" do
        VCR.use_cassette('gists(id)') do
          gist_id = "1393990"
          gist = subject.gists(gist_id)
          gist['id'].should == gist_id
          should_be_a_gist(gist)
        end
      end
    end

    it "should return gists for authenticated user" do
      VCR.use_cassette('gists') do
        gists = subject.gists
        gists.size.should > 0
        should_be_a_gist(gists.first)
      end
    end

    describe "#public" do
      it "should return public gists" do
        VCR.use_cassette('gists.public') do
          gists = subject.gists.public
          gists.size.should > 0
          should_be_a_gist(gists.first)
        end
      end
    end

    describe "#starred" do
      it "should return starred gists" do
        VCR.use_cassette('gists.starred') do
          gists = subject.gists.starred
          gists.size.should > 0
          should_be_a_gist(gists.first)
        end
      end
    end
  end
end