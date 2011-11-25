require 'spec_helper'

describe Ghee::API::Gists do
  subject { Ghee.new(ACCESS_TOKEN) }

  def should_be_a_gist(gist)
    gist['url'].should include('https://api.github.com/gists/')
    gist['user']['url'].should include('https://api.github.com/users/')
    gist['created_at'].should_not be_nil
    gist['files'].should be_instance_of(Hash)
    gist['files'].size.should > 0
  end

  describe "#users" do
    describe "#gists" do
      it "should return users gists" do
        VCR.use_cassette('users(login).gists') do
          gists = subject.users('jonmagic').gists
          gists.size.should > 0
          should_be_a_gist(gists.first)
        end
      end
    end
  end

  describe "#gists" do
    it "should return gists for authenticated user" do
      VCR.use_cassette('gists') do
        gists = subject.gists
        gists.size.should > 0
        should_be_a_gist(gists.first)
      end
    end

    describe "#public" do
      it "should return public gists" do
        VCR.use_cassette('gists.public') do
          gists = subject.gists.public
          gists.size.should > 0
          should_be_a_gist(gists.first)
        end
      end
    end

    describe "#starred" do
      it "should return starred gists" do
        VCR.use_cassette('gists.starred') do
          gists = subject.gists.starred
          gists.size.should > 0
          should_be_a_gist(gists.first)
        end
      end
    end

    describe "#create" do
      it "should create a gist" do
        VCR.use_cassette('gists.create') do
          gist = subject.gists.create({
            :description => "I'm gonna buttah yo bread.",
            :public => true,
            :files => {
              'ghee_test.txt' => {
                :content => "Booya!"
              }
            }
          })
          should_be_a_gist(gist)
        end
      end
    end

    context "with gist id" do
      it "should return single gist" do
        VCR.use_cassette('gists(id)') do
          gist_id = "1393990"
          gist = subject.gists(gist_id)
          gist['id'].should == gist_id
          should_be_a_gist(gist)
        end
      end

      describe "#patch" do
        it "should patch the gist" do
          VCR.use_cassette('gists(id).patch') do
            gist = subject.gists("1393990").patch({
              :files => {
                'test.md' => {
                  :content => 'clarified butter'
                }
              }
            })
            should_be_a_gist(gist)
            gist['files']['test.md']['content'].should == 'clarified butter'
          end
        end
      end

      describe "#star" do
        it "should star the gist" do
          VCR.use_cassette('gists(id).star') do
            subject.gists('1393990').star.should be_true
          end
        end
      end

      describe "#unstar" do
        it "should star the gist" do
          VCR.use_cassette('gists(id).unstar') do
            subject.gists('1393990').unstar.should be_true
          end
        end
      end

      describe "#starred?" do
        it "should return true if gist is starred" do
          VCR.use_cassette('gists(id).starred? is true') do
            subject.gists('1393990').star
            subject.gists('1393990').starred?.should be_true
          end
        end

        it "should return false if gist is unstarred" do
          VCR.use_cassette('gists(id).starred? is false') do
            subject.gists('1393990').unstar
            subject.gists('1393990').starred?.should be_false
          end
        end
      end

      describe "#destroy" do
        it "should delete the gist and return true" do
          VCR.use_cassette('gists(id).destroy true') do
            gist = subject.gists.create({:public => false, :files => {'file.txt' => {:content => 'ready to destroy'}}})
            subject.gists(gist['id']).destroy.should be_true
          end
        end

        it "should return false if gist doesn't exist" do
          VCR.use_cassette('gists(id).destroy false') do
            subject.gists("12345678901234567890").destroy.should be_false
          end
        end
      end
    end
  end
end