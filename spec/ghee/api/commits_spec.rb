require 'spec_helper'

describe Ghee::API::Repos::Commits do
  subject { Ghee.new(GH_AUTH) }

  def should_be_a_commit(commit)
    commit.has_key?('sha').should == true
    commit.has_key?('commit').should == true
  end

  def should_be_a_commit_comment(comment)
    comment.has_key?('body').should == true
    comment.has_key?('body_text').should == true
    comment.has_key?('body_html').should == true
  end


  describe 'repo(user,repo)#commits' do
    it 'return a list of commits' do
      VCR.use_cassette("repos(#{GH_USER},#{GH_REPO})commits") do
        commits = subject.repos(GH_USER, GH_REPO).commits
        should_be_a_commit(commits.first)
      end
    end

    context '#commits#status' do
      before :all do
        VCR.use_cassette("repos(#{GH_USER},#{GH_REPO})commits") do
          commits = subject.repos(GH_USER, GH_REPO).commits
          @commit = commits.first
        end
      end
      let(:commit){ @commit }

      it 'adds a status to the commit' do
        VCR.use_cassette("repos(#{GH_USER},#{GH_REPO})statuses") do
          sha = commit['sha']
          state = {state: "pending"}
          status = subject.repos(GH_USER, GH_REPO).statuses(sha, state)

          status['state'].should == 'pending'
        end
      end

      it 'gets a list of statuses' do 
        VCR.use_cassette("repos(#{GH_USER},#{GH_REPO})commits(sha)statuses") do
          sha = commit['sha']
          statuses = subject.repos(GH_USER, GH_REPO).commits(sha).statuses

          statuses.length.should > 0
          statuses.first['state'].should == 'pending'
        end
      end

      it 'gets combined statuses' do
        VCR.use_cassette("repos(#{GH_USER},#{GH_REPO})commits(sha)status") do
          sha = commit['sha']
          status = subject.repos(GH_USER, GH_REPO).commits(sha).status

          status['state'].should == 'pending'
          status.has_key?('total_count').should == true
        end
      end
    end
  end

  describe 'repo(user,repo)#comments' do
    it 'return a list of commit comments' do
      VCR.use_cassette("repos(#{GH_USER},#{GH_REPO})comments") do
        comments = subject.repos(GH_USER, GH_REPO).comments
        should_be_a_commit_comment(comments.first)
      end
    end
  end
end
