class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    # The Repos module handles all of the Github Repo
    # API endpoints
    #
    module Repos

      # Repos::Proxy inherits from Ghee::Proxy and
      # enables defining methods on the proxy object
      #
      class Proxy < ::Ghee::ResourceProxy
        def compare(base, head)
          raise NotImplemented
        end
        def commits(sha=nil, &block)
          raise NotImplemented
        end
      end

      module Commits
        class Proxy < ::Ghee::ResourceProxy
        end
      end
    end
  end
end


