require 'spec_helper'

describe Ghee::API::Repos::Labels do
  subject { Ghee.new(GH_AUTH) }

  def should_be_a_label(label)
    label['name'].should_not be_nil
    label['color'].should_not be_nil
  end

  describe "#repos(login,name)#labels" do
    it "should return repos labels" do
      VCR.use_cassette("repos(\"#{GH_USER}/#{GH_REPO}\").labels") do
        labels = subject.repos("#{GH_USER}/#{GH_REPO}").labels
        labels.size.should > 0
        should_be_a_label(labels.first)
      end
    end

    describe "#repos(login,name)#labels(bug)" do
      it "should return a label by name" do
        VCR.use_cassette("repos(#{GH_USER},#{GH_REPO}).label(bug)") do
          label = subject.repos(GH_USER, GH_REPO).labels("bug")
          should_be_a_label(label)
        end
      end

      # Testing label proxy
      context "with label name" do
        before(:all) do
          VCR.use_cassette "labels.test" do
            @repo = subject.repos(GH_USER, GH_REPO)
            @test_label = @repo.labels({
              :name => "Test label"
            })
          end
        end
        let(:test_label) { @test_label }
        let(:test_repo) { @repo }

        describe "#patch" do
          it "should patch the label" do
            VCR.use_cassette "labels(name).patch" do
              label = test_repo.labels(test_label["name"]).patch({
                :color => "ffffff"
              })
              should_be_a_label(label)
              label["color"].should == "ffffff"
            end
          end
        end
      end
    end
  end
end
