require 'faraday'
require 'faraday_middleware'
require 'multi_json'

class Ghee
  class Connection < Faraday::Connection
    attr_reader :access_token

    # Instantiates connection, accepts an access_token
    # for authenticated access
    #
    # access_token - String of the access token
    #
    def initialize(access_token=nil)
      @access_token = access_token

      super('https://api.github.com') do |builder|
        builder.use     Faraday::Request::JSON
        builder.use     Faraday::Response::ParseJson
        builder.adapter Faraday.default_adapter
      end

      self.headers["Authorization"] = "token #{access_token}" if access_token
      self.headers["Accept"] = 'application/json'
    end
  end
end