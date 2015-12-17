class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    # The Repos module handles all of the Github Repo
    # API endpoints
    #
    module Repos

      module Labels
        class Proxy < ::Ghee::ResourceProxy
        end
      end

      # Gists::Proxy inherits from Ghee::Proxy and
      # enables defining methods on the proxy object
      #
      class Proxy < ::Ghee::ResourceProxy

        # Get labels for a repo
        #
        # id - Number get a specific label (optional)
        #
        # Returns json
        #
        def labels(number=nil, params={})
          raise NotImplemented
        end
      end
    end
  end
end
