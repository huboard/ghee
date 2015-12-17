class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    # The Repos module handles all of the Github Repo
    # API endpoints
    #
    module Repos

      module Keys
        class Proxy < ::Ghee::ResourceProxy
          include Ghee::CUD
        end
      end

      # Proxy inherits from Ghee::Proxy and
      # enables defining methods on the proxy object
      #
      class Proxy < ::Ghee::ResourceProxy

        def keys(id=nil)
          raise NotImplemented
        end
      end
    end
    # The Users module handles all of the Github Repo
    # API endpoints
    #
    module Users

      module Keys
        class Proxy < ::Ghee::ResourceProxy
          include Ghee::CUD
        end
      end

      # Proxy inherits from Ghee::Proxy and
      # enables defining methods on the proxy object
      #
      class Proxy < ::Ghee::ResourceProxy

        def keys(id=nil)
          raise NotImplemented
        end
      end
    end
  end
end



