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
        include Ghee::CUD

        # Gists for a user
        #
        # Returns json
        #
        def gists(params={})
          Ghee::API::Gists::Proxy.new(connection,"#{path_prefix}/gists",params)
        end

        # Repos for a user
        #
        # Returns json
        #
        def repos(name=nil, params={})
          params = name if name.is_a?Hash
          prefix = name.is_a?(String) ? "./repos/#{self["login"]}/#{name}" : "#{path_prefix}/repos" 
          Ghee::API::Repos::Proxy.new(connection,prefix, params)
        end

        # Returns list of the provided users organizations or 
        # an organization by name
        #
        # org - String name of the organization (optional)
        #
        # Returns json
        #
        def orgs(org=nil, params={})
          params = org if org.is_a?Hash
          prefix = org.is_a?(String) ? "./orgs/#{org}" : "#{path_prefix}/orgs"
          Ghee::API::Orgs::Proxy.new(connection, prefix, params)
        end

       
      end

      # Get authenticated user
      #
      # Returns json
      #
      def user
        Proxy.new(connection, './user')
      end

      # Get a single user
      #
      # user - String of user login
      #
      # Returns json
      #
      def users(user)
        Proxy.new(connection, "./users/#{user}")
      end
    end
  end
end
