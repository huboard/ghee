class Ghee
  def self.basic_auth(user_name, password, api_url = nil)
    options = { :basic_auth  => {:user_name => user_name, :password => password} }
    options[:api_url] = api_url if api_url
    Ghee.new options
  end

  def self.access_token(token, api_url = nil)
    options = {  :access_token => token }
    options[:api_url] = api_url if api_url
    Ghee.new  options
  end

  def self.create_token(user_name, password, scopes, api_url = nil)
    auth = Ghee.basic_auth(user_name, password, api_url).authorizations.create({
                                                                                   :scopes => scopes})
    auth["token"]
  end

  module GitHub
    module API
    end
  end
end

require 'ghee/github/api/authorizations'
require 'ghee/github/api/gists'
require 'ghee/github/api/users'
require 'ghee/github/api/events'
require 'ghee/github/api/repos'
require 'ghee/github/api/issues'
require 'ghee/github/api/milestones'
require 'ghee/github/api/orgs'
require 'ghee/github/api/git_data'
require 'ghee/github/api/labels'
require 'ghee/github/api/hooks'
require 'ghee/github/api/collaborators'
require 'ghee/github/api/forks'
require 'ghee/github/api/commits'
require 'ghee/github/api/commit_comments'
require 'ghee/github/api/commit_statuses'
require 'ghee/github/api/keys'
require 'ghee/github/api/watchers'
require 'ghee/github/api/emails'
require 'ghee/github/api/followers'
require 'ghee/github/api/pulls'
require 'ghee/github/api/search'
require 'ghee/github/api/contents'
require 'ghee/github/api/members'
