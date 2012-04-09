require 'spec_helper'

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

  describe "#repos()#commits" do
    it "should return an array of commits" do
      VCR.use_cassette "#repos()#commits", :match_requests_on => MATCHES do
        commits = subject.commits
        commits.size.should > 0
        should_be_a_commit commits.first
      end
    end
  end

  describe "#repos(login,name)#git" do
    describe "#blobs" do
      context "with a test blob" do
        before :all do
          VCR.use_cassette "repos()#git#blobs#create", :match_requests_on => MATCHES do
            @test_blob = subject.git.blobs.create({
              :content => "Oh hello!",
              :encoding => "utf-8"
            });
            @test_blob.should_not be_nil
          end
        end
        let(:test_blob) {@test_blob}

        it "should return a blob" do
          VCR.use_cassette "repos()#git#blobs#sha", :match_requests_on => MATCHES do
            blob = subject.git.blobs(test_blob["sha"])
            should_be_a_blob blob
          end
        end
      end
    end
    describe "#refs" do
      it "should return all the refs" do
        VCR.use_cassette "repos()#git#refs", :match_requests_on => MATCHES do
          refs = subject.git.refs
          refs.size.should > 0
          should_be_a_ref refs.first
        end
      end
    end
    context "with a test commit" do
      before :all do
        VCR.use_cassette "repos()#commits#first", :match_requests_on => MATCHES do
          # create a commit
          @test_commit = subject.commits.first
        end
      end
      let(:test_commit) {@test_commit}

      describe "#trees" do
        it "should return a tree for the commit sha" do
          VCR.use_cassette "repos()#git#trees:sha", :match_requests_on => MATCHES do
            tree = subject.git.trees test_commit["sha"]
            tree.should_not be_nil
          end
        end
      end

      describe "#commits" do
        it "should return a commit" do
          VCR.use_cassette "repos()#git#commit#sha", :match_requests_on => MATCHES do
            commit = subject.git.commits(test_commit["sha"])
            should_be_a_commit commit
          end
        end
      end
    end
  end
end

