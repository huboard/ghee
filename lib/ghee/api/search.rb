
class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    module Repos
      module Issues
        class Proxy < ::Ghee::ResourceProxy
          def search(term, state = "open")
            raise NotImplemented
          end
        end
      end
    end

    # The Search module handles all of the Github Search
    # API endpoints
    #
    module Search
      module Issues
        class Proxy < ::Ghee::ResourceProxy
        end
      end
      class Proxy < ::Ghee::ResourceProxy
        def issues(repo, term, state = "open")
          raise NotImplemented
        end
      end
    end
  end

  def search
    API::Search::Proxy.new(connection,"")
  end
end
