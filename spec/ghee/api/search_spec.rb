require 'spec_helper'

describe Ghee::API::Search do
  subject { Ghee.new(GH_AUTH) }

  def should_be_an_issue(issue)
    issue["user"].should_not be_nil
    issue["comments"].should_not be_nil
  end

  describe "gh#search#issues" do
    it "should search open issues by repo by default" do 
      VCR.use_cassette "gh#search#issues#default" do
        issues = subject.search.issues("#{GH_USER}/#{GH_REPO}", "Seeded")
        issues['issues'].size.should > 0
        should_be_an_issue(issues['issues'].first)
      end
    end
  end
end
