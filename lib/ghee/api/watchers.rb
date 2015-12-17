class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    # The Repos module handles all of the Github Repo
    # API endpoints
    #
    module Repos

      # Proxy inherits from Ghee::Proxy and
      # enables defining methods on the proxy object
      #
      class Proxy < ::Ghee::ResourceProxy

        def watchers
          raise NotImplemented
        end
      end
    end
    module Users
      class Proxy < ::Ghee::ResourceProxy
        def watched
          raise NotImplemented
        end
        def watching?(user,repo)
          raise NotImplemented
        end
        def watch(user, repo)
          raise NotImplemented
        end
        def watch!(user, repo)
          raise NotImplemented
        end
      end
    end
  end
end

