class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    # The Gists module handles all of the Github Gist
    # API endpoints
    #
    module Gists

      # Gists::Proxy inherits from Ghee::Proxy and
      # enables defining methods on the proxy object
      #
      class Proxy < ::Ghee::ResourceProxy

      end

      # Get gists
      #
      # Returns json
      #
      def gists
        ResourceProxy.new(connection, '/gists')
      end
    end
  end
end
