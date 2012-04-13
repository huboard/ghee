require 'spec_helper'

describe Ghee::API::Repos::Milestones do
  subject { Ghee.new(GH_AUTH) }

  def should_be_an_milestone(milestone)
    milestone["title"].should_not be_nil
    milestone["number"].should_not be_nil
    milestone["open_issues"].should_not be_nil
    milestone["closed_issues"].should_not be_nil
  end

  describe "#repos(login,name)#milestones" do
    it "should return repos milestones" do
      VCR.use_cassette("repos(#{GH_USER},#{GH_REPO}).milestones") do
        temp_milestone = subject.repos(GH_USER, GH_REPO).milestones.create({ :title => "Destroy test milestone #{rand(100)}" })

        milestones = subject.repos(GH_USER, GH_REPO).milestones
        milestones.size.should > 0
        should_be_an_milestone(milestones.first)

        subject.repos(GH_USER, GH_REPO).milestones(temp_milestone["number"]).destroy
      end
    end

    describe "#repos(login,name)#milestones#closed" do
      it "should return repos closed milestones" do
        VCR.use_cassette("repos(#{GH_USER},#{GH_REPO}).milestones.closed") do
          temp_milestone = subject.repos(GH_USER, GH_REPO).milestones.create({ :title => "Destroy test milestone #{rand(100)}" })
          subject.repos(GH_USER, GH_REPO).milestones(temp_milestone["number"]).close

          milestones = subject.repos(GH_USER, GH_REPO).milestones.closed
          milestones.size.should > 0
          should_be_an_milestone(milestones.first)
          milestones.each do |i|
            i["state"].should == "closed"
          end

          subject.repos(GH_USER, GH_REPO).milestones(temp_milestone["number"]).destroy
        end
      end
    end

    describe "#repos(login,name)#milestones(1)" do
      it "should return an milestone by id" do
        VCR.use_cassette("repos(#{GH_USER},#{GH_REPO}).milestones(1)") do
          temp_milestone = subject.repos(GH_USER, GH_REPO).milestones.create({ :title => "Destroy test milestone #{rand(100)}" })

          milestone = subject.repos(GH_USER, GH_REPO).milestones(1)
          should_be_an_milestone(milestone)

          subject.repos(GH_USER, GH_REPO).milestones(temp_milestone["number"]).destroy
        end
      end

      describe "#destroy" do
        it "should delete milestone" do
          VCR.use_cassette "milestones(id).destroy" do
            repo = subject.repos(GH_USER, GH_REPO)
            test_milestone = repo.milestones.create({
              :title => "Destroy test milestone #{rand(100)}"
            })
            should_be_an_milestone(test_milestone)
            subject.repos(GH_USER, GH_REPO).milestones(test_milestone["number"]).destroy.should be_true
          end
        end
      end

      # Testing milestone proxy
      context "with milestone number" do
        before(:all) do
          VCR.use_cassette "milestones.test" do
            @repo = subject.repos(GH_USER, GH_REPO)
            @test_milestone = @repo.milestones.create({
              :title => "Test milestone #{rand(100)}"
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
