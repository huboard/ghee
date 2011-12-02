require 'spec_helper'

describe Ghee::API::Events do
  subject { Ghee.new(ACCESS_TOKEN) }

  EventTypes = ["CommitComment","CreateEvent","DeleteEvent","DownloadEvent","FollowEvent",
  "ForkEvent","ForkApplyEvent","GistEvent","GollumEvent","IssueCommentEvent",
  "IssuesEvent","MemberEvent","PublicEvent","PullRequestEvent","PushEvent",
  "TeamAddEvent","WatchEvent"]

  def should_be_an_event(event)
    EventTypes.should include(event['type'])
    event['repo'].should be_instance_of(Hash)
    event['actor'].should be_instance_of(Hash)
    event['org'].should be_instance_of(Hash)
    event['created_at'].should_not be_nil
  end

  describe "#events" do
    it "should return public events" do
      VCR.use_cassette('events') do
        events = subject.events
        events.size.should > 0
        should_be_an_event(events.first)
      end
    end
  end
end
