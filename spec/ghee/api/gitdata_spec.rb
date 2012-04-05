require 'spec_helper'

describe Ghee::API::Repos::Git do
  subject { Ghee.new(GH_AUTH) }

  def should_be_a_blob(blob)
    blob["content"].should_not be_nil
    blob["encoding"].should_not be_nil
  end

  def should_be_a_commit(commit)
    # assert its a commit
  end

  describe "#repos(login,name)#git" do 
    describe "#blobs" do
      context "with a test blob" do
        before :all do 
          VCR.use_cassette "repos()#git#blobs#create" do 
            @test_blob = subject.repos(GH_USER, GH_REPO).git.blobs.create({
              :content => "Oh hello!",
              :encoding => "utf-8"
            });
            @test_blob.should_not be_nil
          end
        end
        let(:test_blob) {@test_blob}

        it "should return a blob" do
          VCR.use_cassette "repos()#git#blobs#sha" do
            blob = subject.repos(GH_USER, GH_REPO).git.blobs(test_blob["sha"])
            should_be_a_blob blob
          end
        end
      end
    end
    describe "#commits" do
      context "with a test commit" do
        before :all do 
          VCR.use_cassette "repos()#git#commits#create" do 
            # create a commit
          end
        end
        let(:test_commit) {@test_commit}

        it "should return a commit" do
          VCR.use_cassette "repos()#git#commit#sha" do
            #commit = subject.repos(GH_USER, GH_REPO).git.commits(test_commit["sha"])
            #should_be_a_commit commit
          end
        end
      end
    end
  end
end

