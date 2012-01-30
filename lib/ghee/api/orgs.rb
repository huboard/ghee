class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    # The Orgs module handles all of the Github Organization
    # API endpoints
    #
    module Orgs

      # Orgs::Proxy inherits from Ghee::Proxy and
      # enables defining methods on the proxy object
      #
      class Proxy < ::Ghee::ResourceProxy
        include Ghee::CUD

        # Repos for a orgs
        #
        # Returns json
        #
        def repos(name=nil)
          return connection.get("#{path_prefix}/repos").body if name.nil?
          Ghee::API::Repos::Proxy.new(connection,"/repos/#{self["login"]}/#{name}")
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

