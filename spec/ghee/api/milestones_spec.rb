require 'spec_helper'

describe Ghee::API::Milestones do 
  subject { Ghee.new(ACCESS_TOKEN) }

  def should_be_an_milestone(milestone)
    milestone["creator"]["login"].should_not be_nil
    milestone["title"].should_not be_nil
  end

  describe "#repos(login,name)#milestones" do
    it "should return repos milestones" do
      VCR.use_cassette("repos(rauhryan,ghee_test).milestones") do
        milestones = subject.repos("rauhryan","ghee_test").milestones
        milestones.size.should > 0
        should_be_an_milestone(milestones.first)
      end
    end
    describe "#repos(login,name)#milestones#closed" do
      it "should return repos closed milestones" do
        VCR.use_cassette("repos(rauhryan,ghee_test).milestones.closed") do
          milestones = subject.repos("rauhryan","ghee_test").milestones.closed
          milestones.size.should > 0
          should_be_an_milestone(milestones.first)
          milestones.each do |i|
            i["state"].should == "closed"
          end
        end
      end
    end
    describe "#repos(login,name)#milestones(1)" do
      it "should return an milestone by id" do 
        VCR.use_cassette("repos(rauhryan,ghee_test).milestones(1)") do
          milestone = subject.repos("rauhryan","ghee_test").milestones(1)
          should_be_an_milestone(milestone)
        end
      end
      describe "#destroy" do
          it "should delete milestone" do
            VCR.use_cassette "milestones(id).destroy" do
              repo = subject.repos("rauhryan","ghee_test")
              test_milestone = repo.milestones.create({
                :title => "Destroy test milestone"
              })
              should_be_an_milestone(test_milestone)
              subject.repos("rauhryan","ghee_test").milestones(test_milestone["number"]).destroy.should be_true
            end
          end
      end

      # Testing milestone proxy
      context "with milestone number" do
        before(:all) do
          VCR.use_cassette "milestones.test" do
            @repo = subject.repos("rauhryan","ghee_test")
            @test_milestone = @repo.milestones.create({
              :title => "Test milestone"
            })
          end
        end
        let(:test_milestone) { @test_milestone }
        let(:test_repo) { @repo }

        describe "#patch" do 
          it "should patch the milestone" do
            VCR.use_cassette "milestones(id).patch" do
              milestone = test_repo.milestones(test_milestone["number"]).patch({
                :description => "awesome description"
              })
              should_be_an_milestone(milestone)
              milestone["description"].should == "awesome description"
            end
          end
        end

        describe "#close" do
          it "should close the milestone" do 
            VCR.use_cassette "milestones(id).close" do
              closed = test_repo.milestones(test_milestone["number"]).close
              closed.should be_true
            end
          end
        end
      end
    end
  end
end

