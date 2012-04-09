require 'spec_helper'

describe Ghee::API::Users do
  subject { Ghee.new(GH_AUTH) }

  describe "#user" do
    it "should return authenticated user" do
      VCR.use_cassette 'user', :match_requests_on => MATCHES do
        user = subject.user
        user['type'].should == 'User'
        user['email'].should_not be_nil
        user['created_at'].should_not be_nil
        user['html_url'].should include('https://github.com/')
        user['name'].should be_instance_of(String)
        user['login'].size.should > 0
      end
    end

    # not sure how to write this test so that it doesn't mess
    # up users info, so I'm just going to take the bio and add
    # a space to the end of it
    describe "#patch" do
      it "should patch the user" do
        VCR.use_cassette 'user.patch', :match_requests_on => MATCHES do
          before_user = subject.user
          after_user = subject.user.patch({
            :bio => "#{before_user['bio']} "
          })
          after_user['bio'].should == "#{before_user['bio']} "
        end
      end
    end

    # clearly this test is going to fail if the authenticated user isn't part of any organizations
    describe "#orgs" do
      it "should return list of orgs" do
        VCR.use_cassette "user.orgs", :match_requests_on => MATCHES do
          orgs = subject.user.orgs
          orgs.size.should > 0
          orgs.first["url"].should include("https://api.github.com/orgs")
        end
      end
    end

    describe "#repos :type => 'public'" do
      it "should only return public repos" do
        VCR.use_cassette "user.repos.public", :match_requests_on => MATCHES do
          repos = subject.user.repos :type => "public"
          repos.size.should > 0
          repos.path_prefix.should == "/user/repos"
          repos.should be_instance_of(Array)
          repos.each do |r|
            r["private"].should be_false
          end
        end
      end
    end

    describe "#repos" do
      it "should return list of repos" do
        VCR.use_cassette "user.repos", :match_requests_on => MATCHES do
          repos = subject.user.repos
          repos.size.should > 0
        end
      end

      describe "#paginate" do
        it "should limit the count to 10" do
          VCR.use_cassette "users(github).repos.paginate", :match_requests_on => MATCHES do
            repos = subject.users("github").repos.paginate :page => 1, :per_page => 10
            repos.size.should == 10
            repos.current_page.should == 1
            repos.next_page.should == 2
          end
        end
        it "should return page 3" do
          VCR.use_cassette "users(github).repos.paginate:page=>3", :match_requests_on => MATCHES do
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
      VCR.use_cassette 'users', :match_requests_on => MATCHES do
        user = subject.users(GH_USER)
        user['type'].should == 'User'
        user['login'].should == CACHED['username']
      end
    end
  end
end
