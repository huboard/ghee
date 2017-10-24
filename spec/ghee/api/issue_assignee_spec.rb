require 'spec_helper'

describe Ghee::API::Repos::Issues do
  subject { Ghee.new(GH_AUTH) }

  context "with issue number" do
    before(:all) do
      VCR.use_cassette "issues.test" do
        @repo = subject.repos(GH_USER, GH_REPO)
        @test_issue = @repo.issues.create({
          :title => "Test issue"
        })
      end
    end
    let(:test_issue) { @test_issue }
    let(:test_repo) { @repo }

    describe "#assignees" do 
      it "should add and remove an assignee for a given issue" do 
        VCR.use_cassette "#repo#issues(id)#assignees#add&remove" do
          issue = test_repo.issues(test_issue["number"]).assignees.add([GH_USER])
          issue['assignees'].size.should > 0
          issue['assignees'].first['login'].should eq(GH_USER)

          issue = test_repo.issues(test_issue["number"]).assignees.add([GH_USER])
          issue['assignees'].size.should > 0
          issue['assignees'].first['login'].should eq(GH_USER)
        end
      end
    end
  end
end

