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
  end

end
