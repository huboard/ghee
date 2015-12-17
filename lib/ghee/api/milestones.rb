class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    module Repos

      # The Milestones module handles all of the Github Repo Milestones
      # API endpoints
      #
      module Milestones


        # Gists::Proxy inherits from Ghee::Proxy and
        # enables defining methods on the proxy object
        #
        class Proxy < ::Ghee::ResourceProxy
          include Ghee::CUD

          # Close milestone - closed milestone by id
          #
          # usage - ghee.repos("my_repo").milestones(1).close
          #
          # returns boolean
          #
          def close
            raise NotImplemented
          end

          # Returns closed milestones
          #
          # Returns json
          #
          def closed
            raise NotImplemented
          end

        end
      end

      # Gists::Proxy inherits from Ghee::Proxy and
      # enables defining methods on the proxy object
      #
      class Proxy < ::Ghee::ResourceProxy

        # Get milestones
        #
        # Returns json
        #
        def milestones(number=nil, params={})
          raise NotImplemented
        end
      end
    end
  end
end


