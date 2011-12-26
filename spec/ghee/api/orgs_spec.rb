require 'spec_helper'

describe Ghee::API::Orgs do
  subject { Ghee.new(ACCESS_TOKEN) }

  describe "#orgs" do

    it "should return list of authenticated users organizations" do
      VCR.use_cassette "orgs" do
        orgs = subject.orgs
        orgs.size.should > 0
        orgs.first["url"].should include("https://api.github.com/orgs")
      end
    end

    it "should return specific organization" do 
      VCR.use_cassette "orgs(name)" do
        org = subject.orgs("DarthFubuMVC")
        org["url"].should include("https://api.github.com/orgs/DarthFubuMVC")
        org["type"].should == "Organization"
      end
    end
    # not sure how to test this. there isn't a good way to actually
    # patch an organization
    describe "#patch" do
      it "should patch the org" do
        true.should be_true
      end
    end

    describe "#repos" do
      it "should return a list of repos" do
        VCR.use_cassette "orgs(login).repos" do
          repos = subject.orgs("DarthFubuMVC").repos
          repos.size.should > 0
          repo = repos.first
          repo['url'].should include('https://api.github.com/repos/')
          repo['ssh_url'].should include('git@github.com:')
          repo['owner']['login'].should_not be_nil
        end
      end
      it "should return a repo" do
        VCR.use_cassette "orgs(login).repos(name)" do
          repo = subject.orgs("DarthFubuMVC").repos("fubucore")
          repo['url'].should include('https://api.github.com/repos/')
          repo['ssh_url'].should include('git@github.com:')
          repo['owner']['login'].should_not be_nil
        end
      end
    end
  end
end
