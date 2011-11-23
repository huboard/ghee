# encoding: UTF-8
class Ghee
  attr_reader :connection

  # sets up a new instance of Ghee, accepts an access_token
  #
  # access_token - String of the access_token
  #
  def initialize(access_token)
    @connection = Ghee::Connection.new(access_token)
  end
end

require 'ghee/version'
require 'ghee/connection'