class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    # The Gists module handles all of the Github Gist
    # API endpoints
    #
    module Gists

      module Comments
        class Proxy < ::Ghee::ResourceProxy
        end
      end

      # Gists::Proxy inherits from Ghee::Proxy and
      # enables defining methods on the proxy object
      #
      class Proxy < ::Ghee::ResourceProxy

        def comments(id = nil)
          raise NotImplemented
        end


        # Star a gist
        #
        # Returns true/false
        #
        def star
          raise NotImplemented
        end

        # Unstar a gist
        #
        # Returns true/false
        #
        def unstar
          raise NotImplemented
        end

        # Returns whether gist is starred
        #
        # Returns true/false
        #
        def starred?
          raise NotImplemented
        end

        # Get public gists
        #
        # Returns json
        #
        def public
          raise NotImplemented
        end

        # Get starred gists
        #
        # Returns json
        #
        def starred
          raise NotImplemented
        end

      end

      # Get gists
      #
      # id - String of gist id
      #
      # Returns json
      #
      def gists(id=nil, params={})
        raise NotImplemented
      end
    end
  end
end
