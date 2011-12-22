# encoding: UTF-8
require 'ghee/version'
require 'ghee/connection'
require 'ghee/resource_proxy'
require 'ghee/api/gists'
require 'ghee/api/users'
require 'ghee/api/events'
require 'ghee/api/repos'

class Ghee
  attr_reader :connection

  include Ghee::API::Gists
  include Ghee::API::Users
  include Ghee::API::Events
  include Ghee::API::Repos

  # Instantiates Ghee, accepts an access_token
  # for authenticated access
  #
  # Access_token - String of the access_token
  #
  def initialize(options = {})
    @connection = Ghee::Connection.new(options)
  end
end
