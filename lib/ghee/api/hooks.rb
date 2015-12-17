class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    # The Repos module handles all of the Github Repo
    # API endpoints
    #
    module Repos


      module Hooks
        class Proxy < ::Ghee::ResourceProxy
          include Ghee::CUD

          # Test hook - This will trigger the hook with the
          # latest push to the current repository.
          #
          def test
            raise NotImplemented
          end


        end
      end

      # Gists::Proxy inherits from Ghee::Proxy and
      # enables defining methods on the proxy object
      #
      class Proxy < ::Ghee::ResourceProxy
        # Get hooks
        #
        # Returns json
        #
        def hooks(number=nil, params={})
          raise NotImplemented
        end
      end
    end
  end
end
