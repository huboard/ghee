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
        include Ghee::CUD


        # Star a gist
        #
        # Returns true/false
        #
        def star
          connection.put("#{path_prefix}/star").status == 204
        end

        # Unstar a gist
        #
        # Returns true/false
        #
        def unstar
          connection.delete("#{path_prefix}/star").status == 204
        end

        # Returns whether gist is starred
        #
        # Returns true/false
        #
        def starred?
          connection.get("#{path_prefix}/star").status == 204
        end

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
      def gists(id=nil, params={})
        params = id if id.is_a?Hash
        path_prefix = (!id.is_a?(Hash) and id) ? "/gists/#{id}" : '/gists'
        Proxy.new(connection, path_prefix,params)
      end
    end
  end
end
