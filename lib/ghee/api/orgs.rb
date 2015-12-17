class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    # The Orgs module handles all of the Github Organization
    # API endpoints
    #
    module Orgs

      module Memberships
        class MembershipsProxy < ::Ghee::ResourceProxy
        end
      end

      # Orgs::Teams module handles all of the Github Organization Teams
      # API endpoints
      #
      module Teams

        # Orgs::Teams::Members module handles all of the Github Organization Teams members
        # API endpoints
        #
        module Members

          # Members::Proxy inherits from Ghee::Proxy and
          # enables defining methods on the proxy object
          #
          class Proxy < ::Ghee::ResourceProxy

              def add(member)
                raise NotImplemented
              end

              def remove(member)
                raise NotImplemented
              end
              def check?(username=nil)
                raise NotImplemented
              end
          end
        end

        # Teams::Proxy inherits from Ghee::Proxy and
        # enables defining methods on the proxy object
        #
        class Proxy < ::Ghee::ResourceProxy
          include Ghee::CUD

          def members(name=nil, &block)
            raise NotImplemented
          end

        end
      end

      # Orgs::Proxy inherits from Ghee::Proxy and
      # enables defining methods on the proxy object
      #
      class Proxy < ::Ghee::ResourceProxy
        include Ghee::CUD

        # Teams for an org
        #
        # Returns json
        #
        def teams(number=nil, &block)
          raise NotImplemented
        end

        # Repos for a orgs
        #
        # Returns json
        #
        def repos(name=nil, &block)
          raise NotImplemented
        end

        # User Membership for an org
        #
        # Returns json
        #

        def memberships(user, &block)
          raise NotImplemented
        end
      end

      # Team by id
      #
      # Returns json
      #
      def team(number, params={})
        raise NotImplemented
      end

      # Returns list of the authenticated users organizations or
      # an organization by name
      #
      # org - String name of the organization (optional)
      #
      # Returns json
      #
      def orgs(name=nil, &block)
        raise NotImplemented
      end
    end
  end
end

