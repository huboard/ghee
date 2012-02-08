require 'spec_helper'

describe Ghee::API::Authorizations do
  subject { Ghee.new(GH_AUTH) }

  describe "#authorizations" do

    context "with a test authorization" do 
      before :all do 
        VCR.use_cassette "authorizations.create.test" do
          @test_auth = subject.authorizations.create :scopes => ["public_repo"]
          @test_auth.should_not be_nil
        end
      end

      let(:test_auth) {@test_auth}

      it "should return an auth" do 
        VCR.use_cassette "authorizations(id)" do 
          auth = subject.authorizations(test_auth["id"])
          auth["scopes"].should include("public_repo")
        end
      end

      it "should return a list of auths" do 
        VCR.use_cassette "authorizations" do 
          auth = subject.authorizations
          auth.size().should > 0
        end
      end

      it "should patch an auth" do 
        VCR.use_cassette "authorization(id).patch" do 
          auth = subject.authorizations(test_auth["id"]).patch :add_scopes => ["repo"]
          auth["scopes"].should include("repo")
        end
      end

      after :all do 
        VCR.use_cassette "authorizations(id).destroy" do 
          subject.authorizations(test_auth["id"]).destroy.should be_true
        end
      end
    end
  end
end
