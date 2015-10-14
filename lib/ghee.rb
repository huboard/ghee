# encoding: UTF-8
require 'ghee/version'
require 'ghee/connection'
require 'ghee/errors'
require 'ghee/uri_escape'
require 'ghee/state_methods'
require 'ghee/resource_proxy'
require 'ghee/api/authorizations'
require 'ghee/api/gists'
require 'ghee/api/users'
require 'ghee/api/events'
require 'ghee/api/repos'
require 'ghee/api/issues'
require 'ghee/api/milestones'
require 'ghee/api/orgs'
require 'ghee/api/git_data'
require 'ghee/api/labels'
require 'ghee/api/hooks'
require 'ghee/api/collaborators'
require 'ghee/api/forks'
require 'ghee/api/commits'
require 'ghee/api/commit_comments'
require 'ghee/api/commit_statuses'
require 'ghee/api/keys'
require 'ghee/api/watchers'
require 'ghee/api/emails'
require 'ghee/api/followers'
require 'ghee/api/pulls'
require 'ghee/api/search'
require 'ghee/api/contents'

class Ghee
  attr_reader :connection

  include Ghee::API::Authorizations
  include Ghee::API::Gists
  include Ghee::API::Users
  include Ghee::API::Events
  include Ghee::API::Repos
  include Ghee::API::Orgs

  # Instantiates Ghee, accepts an access_token
  # for authenticated access
  #
  # Access_token - String of the access_token
  #
  def initialize(options = {}, &block)
    @options = options
    @block = block if block
    return @connection = Ghee::Connection.new(options, &block) 
  end

  def in_parallel(adapter = :typhoeus, &block)
    ghee = self.class.new @options, &@block
    ghee.connection.adapter adapter
    ghee.connection.in_parallel do
      block.call ghee
    end
  end

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
end
