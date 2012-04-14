require 'spec_helper'
require 'time'

describe Ghee::API::Repos::Git do
  subject { Ghee.new(GH_AUTH).repos(GH_USER,GH_REPO) }

  def should_be_a_blob(blob)
    blob["content"].should_not be_nil
    blob["encoding"].should_not be_nil
  end

  def should_be_a_commit(commit)
    # assert its a commit
    commit["sha"].should_not be_nil
  end

  def should_be_a_tree(tree)
    tree["sha"].should_not be_nil
    tree["tree"].size.should > 0
  end

  def should_be_a_ref(ref)
    ref["ref"].should_not be_nil
    ref["url"].should_not be_nil
    ref["object"].should_not be_nil
  end

  def should_be_a_tag(tag) 
    tag["sha"].should_not be_nil
    tag["tag"].should_not be_nil
    tag["message"].should_not be_nil
    tag["tagger"].should_not be_nil
  end

  describe "#repos()#commits" do
    it "should return an array of commits" do
      VCR.use_cassette "#repos()#commits" do
        commits = subject.commits
        commits.size.should > 0
        should_be_a_commit commits.first
      end
    end
    it "should return a single commit" do
      VCR.use_cassette "#repos()#commit(sha)" do 
        sha = subject.commits.first["sha"]
        commit = subject.commits(sha)
        should_be_a_commit commit
      end
    end
    it "should respond to comments" do 
        # check that the method is there
        # Todo: create a comment in the before context
        subject.respond_to?("comments").should be_true
    end
  end

  describe "#repos(login,name)#git" do 
    describe "#tags" do
      context "with a test tags" do
        before :all do 
          VCR.use_cassette "repos()#git#tags#create" do 
            @test_tag = subject.git.tags.create({
              :tag => "test_tag_#{rand(100)}",
              :object => subject.commits.first["sha"],
              :type => "commit",
              :message => "creating a tag with the api",
              :tagger => {
                :name => "Ryan Rauh",
                :email => "rauh.ryan@gmail.com",
                :date => Time.now.iso8601
              }

            });
            @test_tag.should_not be_nil
          end
        end
        let(:test_tag) {@test_tag}

        it "should return a tag" do
          VCR.use_cassette "repos()#git#tags#sha" do
            tag = subject.git.tags(test_tag["sha"])
            should_be_a_tag tag
          end
        end
      end
    end
    describe "#blobs" do
      context "with a test blob" do
        before :all do 
          VCR.use_cassette "repos()#git#blobs#create" do 
            @test_blob = subject.git.blobs.create({
              :content => "Oh hello!",
              :encoding => "utf-8"
            });
            @test_blob.should_not be_nil
          end
        end
        let(:test_blob) {@test_blob}

        it "should return a blob" do
          VCR.use_cassette "repos()#git#blobs#sha" do
            blob = subject.git.blobs(test_blob["sha"])
            should_be_a_blob blob
          end
        end
      end
    end
    describe "#refs" do
      it "should return all the refs" do
        VCR.use_cassette "repos()#git#refs" do
          refs = subject.git.refs
          refs.size.should > 0
          should_be_a_ref refs.first
        end
      end
    end
    context "with a test commit" do
      before :all do 
        VCR.use_cassette "repos()#commits#first" do 
          # create a commit
          @test_commit = subject.commits.first
        end
      end
      let(:test_commit) {@test_commit}

      describe "#trees" do 
        it "should return a tree for the commit sha" do
          VCR.use_cassette "repos()#git#trees:sha" do
            tree = subject.git.trees test_commit["sha"]
            tree.should_not be_nil
          end
        end
      end

      describe "#commits" do
        it "should return a commit" do
          VCR.use_cassette "repos()#git#commit#sha" do
            commit = subject.git.commits(test_commit["sha"])
            should_be_a_commit commit
          end
        end
      end
    end
  end
end

