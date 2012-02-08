require 'spec_helper'

describe Ghee::API::Repos::Hooks do
  subject { Ghee.new(GH_AUTH) }

  def should_be_a_hook(hook)
    hook['url'].should include('hooks')
    hook['active'].should be_true
    hook['events'].size.should > 0
  end

  describe "#repos(login,name)#hooks" do
    context "with a test web hook" do
      before :all do
        VCR.use_cassette "repos(login,name).hook.create.test" do
          @test_hook = subject.repos(GH_USER,GH_REPO).hooks.create({
            :name => "web",
            :config => {:url => "http://google.com"}
          })
          @test_hook.should_not be_nil
        end
      end
      let(:test_hook) {@test_hook}

      it "should return a hook" do
        VCR.use_cassette "repos(login,name).hooks" do
          hooks = subject.repos(GH_USER,GH_REPO).hooks
          should_be_a_hook hooks.first
        end
      end

      it "should patch the hook" do
        VCR.use_cassette "repos(login,name).hooks.patch" do
          hook = subject.repos(GH_USER,GH_REPO).hooks(test_hook['id']).patch({
           :config => {:url => "http://herpderp.com"}
          })
          should_be_a_hook hook
          hook["config"]["url"].should == "http://herpderp.com"
        end

      end

      it "should destroy the hook" do
        VCR.use_cassette "repos(login,name).hooks.destroy" do
          hook = subject.repos(GH_USER,GH_REPO).hooks(test_hook['id']).destroy.should be_true
        end
      end
    end

  end
end

