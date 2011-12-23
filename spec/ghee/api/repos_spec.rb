require 'spec_helper'

describe Ghee::API::Repos do
  subject { Ghee.new(ACCESS_TOKEN) }

  def should_be_a_repo(repo)
    repo['url'].should include('https://api.github.com/repos/rauhryan')
    repo['ssh_url'].should include('git@github.com:rauhryan')
    repo['owner']['login'].should == "rauhryan"
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
        VCR.use_cassette("user.repo(ghee)") do
          repo = subject.user.repo("ghee")
          repo.connection.should_not be_nil
          repo.path_prefix.should == "/repos/rauhryan/ghee"
          should_be_a_repo(repo)
        end
      end
      describe "#issues" do 
        it "should return issues for repo" do
          VCR.use_cassette("user.repo(skipping_stones_repo).issues") do
            issues = subject.user.repo("skipping_stones_repo").issues
            issues.size.should > 0
          end
        end
      end
    end
  end
end
