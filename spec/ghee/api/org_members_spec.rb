require 'spec_helper'
require 'pry'

describe Ghee::API::Orgs::Members do
  subject { Ghee.new(GH_AUTH) }

  def should_be_a_member(member)
    member.has_key?('login').should == true
  end


  describe 'orgs(org)#members' do
    it 'return a list of members' do
      VCR.use_cassette("orgs(#{GH_ORG})members") do
        members = subject.orgs(GH_ORG).members
        should_be_a_member(members.first)
      end
    end
    it 'checks a username for membership' do
      VCR.use_cassette "orgs(#{GH_ORG})member.check?" do
        subject.orgs(GH_ORG).members(GH_USER).check?.should == true
        subject.orgs(GH_ORG).members.check?(GH_USER).should == true
      end
    end
  end

  describe 'orgs(org)#public_members' do
    it 'return a list of public_members' do
      VCR.use_cassette("orgs(#{GH_ORG})public_members") do
        public_members = subject.orgs(GH_ORG).public_members
        should_be_a_member(public_members.first)
      end
    end
    it 'checks a username for public_membership' do
      VCR.use_cassette "orgs(#{GH_ORG})public_member.check?" do
        subject.orgs(GH_ORG).public_members(GH_USER).check?.should == true
        subject.orgs(GH_ORG).public_members.check?(GH_USER).should == true
      end
    end
  end
end
