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
        attr_accessor :repo_name
      end

      # Get repos
      #
      # name - String of the name of the repo
      #
      # Returns json
      #
      def repos(login, name = nil)
        repo = name.nil? ? '' : "#{login}%2F#{name}"
        path_prefix = "./projects/#{repo}"
        proxy = Proxy.new(connection, path_prefix, ::Ghee::GitLab::RepoTranslator.new(:repo))
        proxy.repo_name = repo
        proxy
      end
    end
  end
end
