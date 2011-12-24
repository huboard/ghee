require 'spec_helper'

describe Ghee::API::Repos do
  subject { Ghee.new(ACCESS_TOKEN) }

  def should_be_a_repo(repo)
    repo['url'].should include('https://api.github.com/repos/rauhryan')
    repo['ssh_url'].should include('git@github.com:rauhryan')
    repo['owner']['login'].should == "rauhryan"
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
