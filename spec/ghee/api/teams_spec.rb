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
        VCR.use_cassette "orgs.teams.create.test", :match_requests_on => MATCHES do
          @test_team = subject.orgs(GH_ORG).teams.create({
            :name => "#{(0...8).map{ ('a'..'z').to_a[rand(26)] }.join}"
          })
          @test_team.should_not be_nil
        end
      end
      let(:test_team) {@test_team}

      context "with a member test team" do
        before :all do
          VCR.use_cassette "orgs.teams.create.test_member", :match_requests_on => MATCHES do
            @member_team = subject.orgs(GH_ORG).teams.create({
              :name => "#{(0...8).map{ ('a'..'z').to_a[rand(26)] }.join}"
            })
            @member_team.should_not be_nil
          end
        end
        after :all do
          VCR.use_cassette "orgs.teams.destroy.test_member", :match_requests_on => MATCHES do
              subject.orgs(GH_ORG).teams(member_team["id"]).destroy
          end
        end
        let(:member_team) {@member_team}
        describe "#members" do
          it "should return members" do
            VCR.use_cassette "orgs(name).teams(id).members", :match_requests_on => MATCHES do
              members = subject.orgs.teams(member_team["id"]).members
              members.size.should == 0
            end
          end
          it "should add a member" do
            VCR.use_cassette "orgs(name).teams(id).members.add", :match_requests_on => MATCHES do
              subject.orgs.teams(member_team["id"]).members.add(GH_USER).should be_true
              members = subject.orgs.teams(member_team["id"]).members
              members.first["login"].should == CACHED['username']
              members.size.should > 0
            end
          end
          it "should remove a member" do
            VCR.use_cassette "orgs(name).teams(id).members.remove", :match_requests_on => MATCHES do
              subject.orgs.teams(member_team["id"]).members.remove(GH_USER).should be_true
              members = subject.orgs.teams(member_team["id"]).members
              members.size.should == 0
            end
          end
        end
      end
      it "should return a team" do
        VCR.use_cassette "orgs.teams", :match_requests_on => MATCHES do
          teams = subject.orgs(GH_ORG).teams
          teams.size.should > 0
        end
      end

      it "should patch the team" do
        VCR.use_cassette "orgs.teams.patch", :match_requests_on => MATCHES do
          name = "#{(0...8).map{ ('a'..'z').to_a[rand(26)] }.join}"
          team = subject.orgs(GH_ORG).teams(test_team['id']).patch({
              :name => name
          })
          should_be_a_team team
        end

      end

      it "should destroy the team" do
        VCR.use_cassette "orgs.teams.destroy", :match_requests_on => MATCHES do
          team = subject.orgs(GH_ORG).teams(test_team['id']).destroy.should be_true
        end
      end
    end

  end
end

