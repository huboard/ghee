# encoding: UTF-8
class Ghee
  attr_reader :connection

  # Instantiates Ghee, accepts an access_token
  # for authenticated access
  #
  # Access_token - String of the access_token
  #
  def initialize(access_token=nil)
    @connection = Ghee::Connection.new(access_token)
  end
end

require 'ghee/version'
require 'ghee/connection'