class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    module Membership
      class MembershipProxy < ::Ghee::ResourceProxy
        def admin?
          raise NotImplemented
        end
        def active?
          raise NotImplemented
        end
        def activate!
          raise NotImplemented
        end
      end
    end

    # The Users module handles all of the Github User
    # API endpoints
    #
    module Users

      #Users::Memberships modules handles a users memberships
      #
      #
      module Memberships

        # Memberships::Proxy inherits from Ghee::Proxy and
        # enables defining methods on the proxy object
        #
        class Proxy < ::Ghee::ResourceProxy
          #Org membership for the user
          #
          #State: string to limit scope to either active or
          #pending
          #
          #Returns json
          def org(name, &block)
            raise NotImplemented
          end

        end
      end

      # Users::Proxy inherits from Ghee::Proxy and
      # enables defining methods on the proxy object
      #
      class Proxy < ::Ghee::ResourceProxy
        include Ghee::CUD

        # Gists for a user
        #
        # Returns json
        #
        def gists(params={})
          raise NotImplemented
        end

        # Repos for a user
        #
        # Returns json
        #
        def repos(name=nil, params={})
          raise NotImplemented
        end

        # Returns list of the provided users organizations or
        # an organization by name
        #
        # org - String name of the organization (optional)
        #
        # Returns json
        #
        def orgs(org=nil, params={})
          raise NotImplemented
        end

        # Returns a Memberships Proxy
        def memberships(params={state: "active"}, &block)
          raise NotImplemented
        end
      end

      # Get authenticated user
      #
      # Returns json
      #
      def user(&block)
        raise NotImplemented
      end

      # Get a single user
      #
      # user - String of user login
      #
      # Returns json
      #
      def users(user)
        raise NotImplemented
      end
    end
  end
end
