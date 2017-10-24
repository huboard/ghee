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

  describe "#contents" do 
    it "should return the content from a repo path" do 
      VCR.use_cassette "repos#contents(path)" do
        readme = subject.contents("readme.md")
        readme["path"].downcase.should == "readme.md"
      end
    end
    it "should create a new file in the repo" do 
      temp_file_name = "#{(0...8).map{ ('a'..'z').to_a[rand(26)] }.join}"
      file = subject.contents("#{temp_file_name}.md").create(
        message: "Adds #{temp_file_name}.md through the api",
        content: "# Whoop whoop"
      )
      file['content']['type'].should == "file"
    end
  end

end
