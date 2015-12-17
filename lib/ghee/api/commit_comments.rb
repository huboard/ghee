class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    # The Repos module handles all of the Github Repo
    # API endpoints
    #
    module Repos
      class Proxy < ::Ghee::ResourceProxy

        def comments(id=nil, &block)
          raise NotImplemented
        end
      end
      module Commits
        class Proxy < ::Ghee::ResourceProxy
          def comments(id=nil, &block)
            raise NotImplemented
          end
        end
        module Comments
          class Proxy < ::Ghee::ResourceProxy
          end
        end
      end
    end
  end
end

