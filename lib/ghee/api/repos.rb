class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    # The Repos module handles all of the Github Repo
    # API endpoints
    #
    module Repos

      module Labels
        class Proxy < ::Ghee::ResourceProxy
          include Ghee::CUD
        end
      end

      # Gists::Proxy inherits from Ghee::Proxy and
      # enables defining methods on the proxy object
      #
      class Proxy < ::Ghee::ResourceProxy

        # Get issues
        #
        # Returns json
        #
        def issues(number=nil, params={})
          params = number if number.is_a?Hash
          prefix = (!number.is_a?(Hash) and number) ? "#{path_prefix}/issues/#{number}" : "#{path_prefix}/issues"
          Ghee::API::Issues::Proxy.new(connection, prefix, params)
        end

        # Get labels for a repo
        #
        # id - Number get a specific label (optional)
        #
        # Returns json
        #
        def labels(id=nil)
          prefix = id ? "#{path_prefix}/labels/#{id}" : "#{path_prefix}/labels"
          Ghee::API::Repos::Labels::Proxy.new(connection,prefix)
        end

        # Get milestones
        #
        # Returns json
        #
        def milestones(number=nil)
          prefix = number ? "#{path_prefix}/milestones/#{number}" : "#{path_prefix}/milestones"
          Ghee::API::Milestones::Proxy.new(connection, prefix)
        end

      end

      # Get repos
      #
      # name - String of the name of the repo
      #
      # Returns json
      #
      def repos(login,name)
        path_prefix = "/repos/#{login}/#{name}"
        Proxy.new(connection, path_prefix)
      end

    end
  end
end
