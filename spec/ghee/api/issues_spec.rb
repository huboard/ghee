require 'spec_helper'

describe Ghee::API::Issues do 
  subject { Ghee.new(ACCESS_TOKEN) }

  def should_be_an_issue(issue)
    issue["user"]["login"].should_not be_nil
    issue["comments"].should_not be_nil
  end

  describe "#repos(login,name)#issues" do
    it "should return repos issues" do
      VCR.use_cassette("repos(rauhryan,ghee_test).issues") do
        issues = subject.repos("rauhryan","ghee_test").issues
        issues.size.should > 0
        should_be_an_issue(issues.first)
      end
    end
    describe "#repos(login,name)#issues#closed" do
      it "should return repos closed issues" do
        VCR.use_cassette("repos(rauhryan,ghee_test).issues.closed") do
          issues = subject.repos("rauhryan","ghee_test").issues.closed
          issues.size.should > 0
          should_be_an_issue(issues.first)
          issues.each do |i|
            i["state"].should == "closed"
          end
        end
      end
    end
    describe "#repos(login,name)#issues(1)" do
      it "should return an issue by id" do 
        VCR.use_cassette("repos(rauhryan,ghee_test).issues(1)") do
          issue = subject.repos("rauhryan","ghee_test").issues(1)
          should_be_an_issue(issue)
        end
      end

      # Testing issue proxy
      context "with issue number" do
        before(:all) do
          VCR.use_cassette "issues.test" do
            @repo = subject.repos("rauhryan","ghee_test")
            @test_issue = @repo.issues.create({
              :title => "Test issue"
            })
          end
        end
        let(:test_issue) { @test_issue }
        let(:test_repo) { @repo }

        describe "#patch" do 
          it "should patch the issue" do
            VCR.use_cassette "issues(id).patch" do
              issue = test_repo.issues(test_issue["number"]).patch({
                :body => "awesome description"
              })
              should_be_an_issue(issue)
              issue["body"].should == "awesome description"
            end
          end
        end

        describe "#close" do
          it "should close the issue" do 
            VCR.use_cassette "issues(id).close" do
              closed = test_repo.issues(test_issue["number"]).close
              closed.should be_true
            end
          end
        end

        describe "#comments" do
          context "issue with comments " do
            before :all do
              VCR.use_cassette "issues(id).comments.create.test" do
                @comment = test_repo.issues(test_issue["number"]).comments.create :body => "test comment"
                @comment.should_not be_nil
              end
            end 
            let(:test_comment) { @comment }

            it "should create comment" do 
              VCR.use_cassette "issues(id).comments.create" do
                comment = test_repo.issues(test_issue["number"]).comments.create :body => "test comment"
                comment.should_not be_nil
              end
            end

            it "should return comment by id" do
              VCR.use_cassette "issues.comments(id)" do
                comment = test_repo.issues.comments(test_comment["id"])
                comment.should_not be_nil
                comment["body"].should == "test comment"
              end
            end

            it "should patch comment" do
              VCR.use_cassette "issues.comments(id).patch" do
                body = "some other description"
                comment = test_repo.issues.comments(test_comment["id"]).patch(:body => body)
                comment.should_not be_nil
                comment["body"].should == body
              end
            end

            it "should destroy comment" do
              VCR.use_cassette "issues.comments(id).destroy" do
                comment = test_repo.issues(test_issue["number"]).comments.create :body => "test comment"
                comment.should_not be_nil
                comment["body"].should == "test comment"
                test_repo.issues.comments(comment["id"]).destroy.should be_true
              end
            end

          end

        end
      end
    end
  end
end
