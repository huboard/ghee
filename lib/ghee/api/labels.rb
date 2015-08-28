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

          def patch(name, params={})
            prefix = "#{path_prefix}/#{name}"
            connection.put(prefix, params).body
          end
        end
      end

      # Gists::Proxy inherits from Ghee::Proxy and
      # enables defining methods on the proxy object
      #
      class Proxy < ::Ghee::ResourceProxy

        # Get labels for a repo
        #
        # id - Number get a specific label (optional)
        #
        # Returns json
        #
        def labels(number=nil, params={})
          params = number if number.is_a?Hash
          prefix = (!number.is_a?(Hash) and number)  ? "#{path_prefix}/labels/#{number}" : "#{path_prefix}/labels"
          Ghee::API::Repos::Labels::Proxy.new(connection, prefix, params)
        end
      end
    end
  end
end
