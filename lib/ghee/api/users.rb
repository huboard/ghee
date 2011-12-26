class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    # The Users module handles all of the Github User
    # API endpoints
    #
    module Users

      # Users::Proxy inherits from Ghee::Proxy and
      # enables defining methods on the proxy object
      #
      class Proxy < ::Ghee::ResourceProxy

        # Patch user
        #
        # attributes - Hash of attributes
        #
        # Returns json
        #
        def patch(attributes)
          connection.patch('/user', attributes).body
        end

        # Gists for a user
        #
        # Returns json
        #
        def gists
          connection.get("#{path_prefix}/gists").body
        end

        # Repos for a user
        #
        # Returns json
        #
        def repos(name=nil)
          return connection.get("#{path_prefix}/repos").body if name.nil?
          Ghee::API::Repos::Proxy.new(connection,"/repos/#{self["login"]}/#{name}")
        end

        # Returns list of the provided users organizations or 
        # an organization by name
        #
        # org - String name of the organization (optional)
        #
        # Returns json
        #
        def orgs(org=nil)
          return connection.get("#{path_prefix}/orgs").body if org.nil?
          Ghee::API::Orgs::Proxy.new(connection, "/orgs/#{org}")
        end

       
      end

      # Get authenticated user
      #
      # Returns json
      #
      def user
        Proxy.new(connection, '/user')
      end

      # Get a single user
      #
      # user - String of user login
      #
      # Returns json
      #
      def users(user)
        Proxy.new(connection, "/users/#{user}")
      end
    end
  end
end
