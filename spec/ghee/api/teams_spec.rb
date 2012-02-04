require 'spec_helper'

describe Ghee::API::Orgs::Teams do
  subject { Ghee.new(GH_AUTH) }

  def should_be_a_team(team)
    team['url'].should include('teams')
    team['permission'].should_not be_nil
    team['name'].should_not be_nil
  end

  describe "#orgs#teams" do
    context "with a test team" do
      before :all do
        VCR.use_cassette "orgs.teams.create.test" do
          @test_team = subject.orgs(GH_ORG).teams.create({
            :name => "test_team"
          })
          @test_team.should_not be_nil
        end
      end
      let(:test_team) {@test_team}

      it "should return a team" do
        VCR.use_cassette "orgs.teams" do
          teams = subject.orgs(GH_ORG).teams
          teams.size.should > 0
        end
      end

      it "should patch the team" do
        VCR.use_cassette "orgs.teams.patch" do
          team = subject.orgs(GH_ORG).teams(test_team['id']).patch({
           :name => "herpderp"
          })
          should_be_a_team team
          team["name"].should == "herpderp"
        end

      end

      it "should destroy the team" do
        VCR.use_cassette "orgs.teams.destroy" do
          team = subject.orgs(GH_ORG).teams(test_team['id']).destroy.should be_true
        end
      end
    end

  end
end

