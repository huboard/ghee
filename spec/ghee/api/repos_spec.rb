require 'spec_helper'

describe Ghee::API::Repos do
  subject { Ghee.new(ACCESS_TOKEN) }

  def should_be_a_repo(repo)
    repo['url'].should include('https://api.github.com/repos/')
    repo['ssh_url'].should include('git@github.com:')
    repo['owner']['login'].should_not be_nil
  end
  describe "#repos(login,name)" do
    it "should be a repo" do
      VCR.use_cassette("repos(rauhryan,ghee)") do 
        repo = subject.repos("rauhryan","ghee")
        should_be_a_repo(repo)
      end
    end
    describe "#issues" do 
      it "should return issues for repo" do
        VCR.use_cassette("repo(rauhryan,ghee_test).issues") do
          issues = subject.repos("rauhryan","ghee_test").issues
          issues.size.should > 0
          issues.first["title"].should_not be_nil
        end
      end
    end
    describe "#labels" do
      it "should return all the labels" do
        VCR.use_cassette("repo(rauhryan,ghee_test).labels") do
          labels = subject.repos("rauhryan","ghee_test").labels
          labels.size.should > 0
          labels.first["color"].should_not be_nil
        end
      end
      it "should get a single label" do
        VCR.use_cassette("repo(rauhryan,ghee_test).labels(id)") do
          labels = subject.repos("rauhryan","ghee_test").labels
          first_label = labels.first
          label = subject.repos("rauhryan","ghee_test").labels(first_label["name"])
          first_label["color"].should == label["color"]
          first_label["url"].should == label["url"]
          first_label["name"].should == label["name"]
        end
      end
      it "should patch a label" do
        VCR.use_cassette("repo(rauhryan,ghee_test).labels.patched") do
          label = subject.repos("rauhryan","ghee_test").labels.create :color => "efefef", :name => "patch label"
          label["color"].should == "efefef"
          label["url"].should include "labels/patch"
          label["name"].should == "patch label"
          patched = subject.repos("rauhryan","ghee_test").labels(label["name"]).patch :color => "000000", :name => "patched label"
          patched["color"].should == "000000"
          patched["url"].should include "labels/patched"
          patched["name"].should == "patched label"
          subject.repos("rauhryan","ghee_test").labels(patched["name"]).destroy.should be_true
        end
      end
      it "should create a label" do
        VCR.use_cassette("repo(rauhryan,ghee_test).labels.create") do
          label = subject.repos("rauhryan","ghee_test").labels.create :color => "efefef", :name => "created label"
          label["color"].should == "efefef"
          label["url"].should include "labels/created"
          label["name"].should == "created label"
          subject.repos("rauhryan","ghee_test").labels(label["name"]).destroy.should be_true
        end
      end
    end
    describe "#milestones" do 
      it "should return milestones for repo" do
        VCR.use_cassette("repo(rauhryan,ghee_test).milestones") do
          milestones = subject.repos("rauhryan","ghee_test").milestones
          milestones.size.should > 0
          milestones.first["title"].should_not be_nil
        end
      end
    end
  end

  describe "#orgs" do
    describe "#repos" do 
      it "should return orgs repos" do
        VCR.use_cassette('orgs(DarthFubuMVC).repos') do
          repos = subject.orgs("DarthFubuMVC").repos
          repos.size.should > 0
          should_be_a_repo(repos.first)
        end
      end
    end
  end
  describe "#user" do
    describe "#repos" do
      it "should return users repos" do
        VCR.use_cassette('users(login).repos') do
          repos = subject.users("rauhryan").repos
          repos.size.should > 0
          should_be_a_repo(repos.first)
        end
      end
    end
    describe "#repo" do
      it "should return a repo" do
        VCR.use_cassette("user.repos(ghee)") do
          repo = subject.user.repos("ghee")
          repo.connection.should_not be_nil
          repo.path_prefix.should == "/repos/rauhryan/ghee"
          should_be_a_repo(repo)
        end
      end
      describe "#milestones" do 
        it "should return milestones for repo" do
          VCR.use_cassette("user.repos(ghee_test).milestones") do
            milestones = subject.user.repos("ghee_test").milestones
            milestones.size.should > 0
            milestones.first["title"].should_not be_nil
          end
        end
      end
      describe "#issues" do 
        it "should return issues for repo" do
          VCR.use_cassette("user.repos(ghee_test).issues") do
            issues = subject.user.repos("ghee_test").issues
            issues.size.should > 0
          end
        end
      end
    end
  end
end
