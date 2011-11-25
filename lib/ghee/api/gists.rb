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

        # Get public gists
        #
        # Returns json
        #
        def public
          connection.get("#{path_prefix}/public").body
        end

        # Get starred gists
        #
        # Returns json
        #
        def starred
          connection.get("#{path_prefix}/starred").body
        end
      end

      # Get gists
      #
      # id - String of gist id
      #
      # Returns json
      #
      def gists(id=nil)
        path_prefix = id ? "/gists/#{id}" : '/gists'
        Proxy.new(connection, path_prefix)
      end
    end
  end
end
