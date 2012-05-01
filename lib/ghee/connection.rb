require 'faraday'
require 'faraday_middleware'
require 'multi_json'

class Ghee
  class Connection < Faraday::Connection
    attr_reader :hash

    # Instantiates connection, accepts an options hash
    # for authenticated access
    #
    # OAuth2 expects
    #   :access_token => "OAuth Token" 
    #
    # Basic auth expects
    #   :basic_auth => {:user_name => "octocat", :password => "secret"}
    def initialize(hash={})
      @hash = hash
      access_token = hash[:access_token] if hash.has_key?:access_token
      basic_auth = hash[:basic_auth] if hash.has_key?:basic_auth

      super('https://api.github.com') do |builder|
        builder.use     FaradayMiddleware::EncodeJson
        builder.use     FaradayMiddleware::ParseJson
        builder.adapter Faraday.default_adapter
      end

      self.headers["Authorization"] = "token #{access_token}" if access_token
      self.basic_auth(basic_auth[:user_name], basic_auth[:password]) if basic_auth
      self.headers["Accept"] = 'application/json'
    end
  end
end
