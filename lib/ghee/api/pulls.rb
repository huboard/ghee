class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    # The Repos module handles all of the Github Repo
    # API endpoints
    #
    module Repos

      module Pulls
        class Proxy < ::Ghee::ResourceProxy
          include Ghee::CUD

          def commits
            raise NotImplemented
          end

          def files
            raise NotImplemented
          end

          def merge?
            raise NotImplemented
          end

          def merge!(message=nil)
            raise NotImplemented
          end
        end
      end

      # Gists::Proxy inherits from Ghee::Proxy and
      # enables defining methods on the proxy object
      #
      class Proxy < ::Ghee::ResourceProxy
        def pulls(number=nil, params={})
          raise NotImplemented
        end
      end
    end
  end
end

