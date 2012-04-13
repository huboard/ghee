require 'spec_helper'

describe Ghee::API::Repos::Collaborators do
  subject { Ghee.new(GH_AUTH).repos(GH_USER, GH_REPO) }
  
  describe "#collaborators" do

    # dont have a good way to test the collaborators api
    it "should have a collaborators method" do
      subject.respond_to?("collaborators").should be_true
    end

  end
end
