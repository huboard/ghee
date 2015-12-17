class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    # The Repos module handles all of the Github Repo
    # API endpoints
    #
    module Repos

      module Collaborators
        class Proxy < ::Ghee::ResourceProxy
          def add(member)
            raise NotImplemented
          end

          def remove(member)
            raise NotImplemented
          end
        end
      end

      # Repos::Proxy inherits from Ghee::Proxy and
      # enables defining methods on the proxy object
      #
      class Proxy < ::Ghee::ResourceProxy
        def collaborators(user=nil, &block)
          raise NotImplemented
        end
      end
    end
  end
end
