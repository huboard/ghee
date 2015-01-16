require 'spec_helper'

describe Ghee::API::Repos::Contents do
  subject { Ghee.new(GH_AUTH).repos(GH_USER, GH_REPO) }

  describe "#readme" do
    it "should return the repos readme" do
      VCR.use_cassette "repos#readme" do
        readme = subject.readme
        readme["name"].downcase.should == "readme.md"
      end
    end

    it "should return the repos readme" do
      VCR.use_cassette "repos#readme#raw" do
        readme = subject.readme do |req|
          req.headers["Accept"] = "application/vnd.github.v3.raw"
        end
        readme.should be_instance_of String
      end
    end
  end

end
