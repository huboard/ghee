class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    # The Repos module handles all of the Github Repo
    # API endpoints
    #
    module Repos

      module Forks
        class Proxy < ::Ghee::ResourceProxy
           def create(org=nil)
             params = org ? {:org => org} : {}
             connection.post(path_prefix, params).body
           end
        end
      end

      # Gists::Proxy inherits from Ghee::Proxy and
      # enables defining methods on the proxy object
      #
      class Proxy < ::Ghee::ResourceProxy
        def forks(params={})
          Ghee::API::Repos::Forks::Proxy.new connection, "#{path_prefix}/forks", params
        end
      end
    end
  end
end

