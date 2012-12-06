# encoding: UTF-8
require 'ghee/version'
require 'ghee/connection'
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
require 'ghee/api/downloads'
require 'ghee/api/labels'
require 'ghee/api/hooks'
require 'ghee/api/collaborators'
require 'ghee/api/forks'
require 'ghee/api/commits'
require 'ghee/api/keys'
require 'ghee/api/watchers'
require 'ghee/api/emails'
require 'ghee/api/followers'
require 'ghee/api/pulls'

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
  def initialize(options = nil, &block)
    
    return @connection = Ghee::Connection.new(options, &block) unless options.nil?

    begin
      token = ENV["GH_TOKEN"] || `git config github.token`
      @connection = Ghee::Connection.new :access_token => token unless token.empty?
      raise "Couldn't find an auth token. Please run `ghee install <username>`" if token.empty?
    rescue Errno::ENOENT
      raise "Couldn't find git"
    end
  end

  def self.basic_auth(user_name, password, api_url = nil)
      Ghee.new :basic_auth  => {:user_name => user_name, :password => password, :api_url => api_url}
  end

  def self.access_token(token, api_url = nil)
    Ghee.new :access_token => token, :api_url => api_url
  end

  def self.create_token(user_name, password, scopes, api_url = nil)
    auth = Ghee.basic_auth(user_name, password, api_url).authorizations.create({
      :scopes => scopes})
    auth["token"]
  end
end
