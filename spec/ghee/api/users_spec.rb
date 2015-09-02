require 'spec_helper'

describe Ghee::API::Users do
  subject { Ghee.new(GH_AUTH) }

  describe "#memberships" do
    it "should return a list of memberships" do
      VCR.use_cassette('user.memberships') do
        memberships = subject.user.memberships
        memberships.size.should > 0
      end
    end
    it "should return a single membership" do
      VCR.use_cassette('user.memberships.org(org)') do
        memberships = subject.user.memberships.org(GH_ORG)
        memberships['state'].should == 'active'
        memberships.active?.should be_true
        memberships.admin?.should be_true
      end
    end
  end

  describe "#user" do
    it "should return authenticated user" do
      VCR.use_cassette('user') do
        user = subject.user
        user['type'].should == 'User'
        user['created_at'].should_not be_nil
        user['html_url'].should include('https://github.com/')
        user['login'].size.should > 0
      end
    end

    describe "#patch" do
      it "should patch the user" do
        VCR.use_cassette('user.patch') do
          user = subject.user
          user.has_key?("name").should == true
          user.has_key?("email").should == true
          user.has_key?("company").should == true
        end
      end
    end

    # clearly this test is going to fail if the authenticated user isn't part of any organizations
    describe "#orgs" do 
      it "should return list of orgs" do
        VCR.use_cassette "user.orgs" do
          orgs = subject.user.orgs
          orgs.size.should > 0
          orgs.first["url"].should include("https://api.github.com/orgs")
        end
      end
    end

    describe "#repos :type => 'public'" do
      it "should only return public repos" do
        VCR.use_cassette "user.repos.public" do
          repos = subject.user.repos :type => "public"
          repos.size.should > 0
          repos.path_prefix.should == "./user/repos"
          repos.should be_instance_of(Array)
          repos.each do |r|
            r["private"].should be_false
          end
        end
      end
    end

    describe "#repos" do
      it "should return list of repos" do
        VCR.use_cassette "user.repos" do
          repos = subject.user.repos
          repos.size.should > 0
        end
      end

      describe "#paginate" do
        it "should limit the count to 10" do
          VCR.use_cassette "users(github).repos.paginate" do
            repos = subject.users("github").repos.paginate :page => 1, :per_page => 10
            repos.size.should == 10
            repos.current_page.should == 1
            repos.next_page.should == 2
          end
        end
        it "should return page 3" do
          VCR.use_cassette "users(github).repos.paginate:page=>3" do
            repos = subject.users("github").repos.paginate :page => 3, :per_page => 10
            repos.size.should == 10
            repos.current_page.should == 3
            repos.next_page.should == 4
            repos.prev_page.should == 2
            repos.first_page.should == 1
            # no consistent way to check last page
            repos.last_page.should >= 4
          end
        end
      end

    end
  end

  describe "#users" do
    it "should return given user" do
      VCR.use_cassette('users') do
        user = subject.users('jonmagic')
        user['type'].should == 'User'
        user['login'].should == 'jonmagic'
      end
    end
    describe "#emails" do
      xit "should add and remove emails" do 
        VCR.use_cassette("user#emails") do
          user = subject.user
          emails = user.emails.add (["support@microsoft.com","octocat@microsoft.com"])
          emails.map{ |e| e['email'] }.should include("support@microsoft.com")
          emails.map{ |e| e['email'] }.should include("octocat@microsoft.com")
          user.emails.remove(["support@microsoft.com","octocat@microsoft.com"]).should be_true
          emails = user.emails
          emails.map{ |e| e['email'] }.should_not include("support@microsoft.com")
          emails.map{ |e| e['email'] }.should_not include("octocat@microsoft.com")
        end
      end
    end
  end
end
