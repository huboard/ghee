class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    # The Orgs module handles all of the Github Organization
    # API endpoints
    #
    module Orgs

      module Teams
        class Proxy < ::Ghee::ResourceProxy
          include Ghee::CUD
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
        def teams(number=nil,params={})
          params = number if number.is_a?Hash
          prefix = (!number.is_a?(Hash) and number) ? "/teams/#{number}" : "#{path_prefix}/teams"
          Ghee::API::Orgs::Teams::Proxy.new(connection, prefix, params)
        end

        # Repos for a orgs
        #
        # Returns json
        #
        def repos(name=nil,params={})
          params = name if name.is_a?Hash
          prefix = (!name.is_a?(Hash) and name) ? "/repos/#{self["login"]}/#{name}" : "#{path_prefix}/repos"
          Ghee::API::Repos::Proxy.new(connection,prefix,params)
        end
      end

      # Returns list of the authenticated users organizations or 
      # an organization by name
      #
      # org - String name of the organization (optional)
      #
      # Returns json
      #
      def orgs(org=nil)
        return connection.get("/user/orgs").body if org.nil?
        Proxy.new(connection, "/orgs/#{org}")
      end
    end
  end
end

