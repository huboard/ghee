require 'spec_helper'

describe Ghee::API::Repos::Collaborators do
  subject { Ghee.new(GH_AUTH).repos(GH_USER, GH_REPO) }
  
  describe "#collaborators" do

    # dont have a good way to test the collaborators api
    it "should have a collaborators method" do
      subject.respond_to?("collaborators").should be_true
    end

  end
  describe "#assignees" do
    it "should have at least one assignee" do
      VCR.use_cassette "#repos#assignees" do
        subject.assignees.size.should > 0
      end
    end
    it "current user should be an assignee" do
      VCR.use_cassette "#repos#assignees#check" do
        subject.assignees.check?(GH_USER).should be_true
      end

    end
  end
end
