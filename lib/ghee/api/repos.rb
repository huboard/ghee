class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    # The Repos module handles all of the Github Repo
    # API endpoints
    #
    module Repos

      # Gists::Proxy inherits from Ghee::Proxy and
      # enables defining methods on the proxy object
      #
      class Proxy < ::Ghee::ResourceProxy

      end

      # Get repos
      #
      # name - String of the name of the repo
      #
      # Returns json
      #
      def repos(name = nil)
        path_prefix = login ? "/users/#{login}/repos" : "user/repos"
        Proxy.new(connection, path_prefix)
      end

    end
  end
end
