class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    # The Repos module handles all of the Github Repo
    # API endpoints
    #
    module Repos
      module Commits
        class Proxy < ::Ghee::ResourceProxy

          def statuses(id=nil, &block)
            raise NotImplemented
          end
          def status(&block)
            raise NotImplemented
          end
        end
        module Statuses
          class Proxy < ::Ghee::ResourceProxy
          end
        end
      end
    end
  end
end

