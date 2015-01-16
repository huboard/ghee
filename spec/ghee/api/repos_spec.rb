require 'spec_helper'

describe Ghee::API::Repos do
  subject { Ghee.new(GH_AUTH) }

  def should_be_a_repo(repo)
    repo['url'].should include('https://api.github.com/repos/')
    repo['ssh_url'].should include('git@github.com:')
    repo['owner']['login'].should_not be_nil
  end


  describe "#repos(login,name)" do
    it "should be a repo" do
      VCR.use_cassette("repos(#{GH_USER},#{GH_REPO})") do
        repo = subject.repos(GH_USER, GH_REPO)
        should_be_a_repo(repo)
      end
    end

    describe "#issues" do
      it "should return issues for repo" do
        VCR.use_cassette("repo(#{GH_USER},#{GH_REPO}).issues") do
          issues = subject.repos(GH_USER, GH_REPO).issues
          issues.is_a?(Array).should be_true
          issues.size.should > 0
          issues.first["title"].should_not be_nil
        end
      end
    end

    describe "#labels" do
      context "" do
        before :all do
          VCR.use_cassette "#labels#create" do
            @temp_label = subject.repos(GH_USER, GH_REPO).labels.create({:color => "efefef", :name => "#{(0...8).map{ ('a'..'z').to_a[rand(26)] }.join}"})
          end
        end
        let(:test_label) {@temp_label}
        after :all do
          VCR.use_cassette "#labels#destroy" do
            subject.repos(GH_USER, GH_REPO).labels(test_label['name']).destroy
          end
        end
        it "should return all the labels" do
          VCR.use_cassette("repo(#{GH_USER},#{GH_REPO}).labels") do

            labels = subject.repos(GH_USER, GH_REPO).labels
            labels.size.should > 0
            labels.first["color"].should_not be_nil

          end
        end

        it "should get a single label" do
          VCR.use_cassette("repo(#{GH_USER},#{GH_REPO}).labels(id)") do

            label = subject.repos(GH_USER,GH_REPO).labels(test_label["name"])
            label["color"].should == 'efefef'
            label["name"].should == test_label["name"]

          end
        end

        it "should patch a label" do
          VCR.use_cassette("repo(#{GH_USER},#{GH_REPO}).labels.patched") do
            name = "patch label #{Guid::guid}"
            label = subject.repos(GH_USER, GH_REPO).labels.create(:color => "efefef", :name => name)
            label["color"].should == "efefef"
            label["url"].should include "labels/patch"

            patched = subject.repos(GH_USER, GH_REPO).labels(label["name"]).patch(:color => "000000", :name => "patched label")
            patched["color"].should == "000000"
            patched["url"].should include "labels/patched"

            subject.repos(GH_USER, GH_REPO).labels(patched["name"]).destroy.should be_true
          end
        end

      end
    end
  end

  describe "#user" do
    describe "#repos" do
      it "should return users repos" do
        VCR.use_cassette('users(login).repos') do
          repos = subject.users(GH_USER).repos
          repos.size.should > 0
          should_be_a_repo(repos.first)
        end
      end
    end

    describe "#repo" do
      it "should return a repo" do
        VCR.use_cassette("user.repos(#{GH_REPO})") do
          repo = subject.user.repos(GH_REPO)
          repo.connection.should_not be_nil
          repo.path_prefix.should == "./repos/#{GH_USER}/#{GH_REPO}"
          should_be_a_repo(repo)
        end
      end

      describe "#milestones" do
        it "should return milestones for repo" do
          VCR.use_cassette("user.repos(#{GH_REPO}).milestones") do
            milestones = subject.user.repos(GH_REPO).milestones
            milestones.should be_instance_of(Array)
          end
        end
      end

      describe "#issues" do
        it "should return issues for repo" do
          VCR.use_cassette("user.repos(#{GH_REPO}).issues") do
            issues = subject.user.repos(GH_REPO).issues
            issues.should be_instance_of(Array)
          end
        end
      end
    end
  end
end
