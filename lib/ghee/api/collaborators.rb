class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    # The Repos module handles all of the Github Repo
    # API endpoints
    #
    module Repos

      module Collaborators
        class Proxy < ::Ghee::ResourceProxy
          def add(member)
            connection.put("#{path_prefix}/#{member}").status == 204
          end

          def remove(member)
            connection.delete("#{path_prefix}/#{member}").status == 204
          end
        end
      end

      # Repos::Proxy inherits from Ghee::Proxy and
      # enables defining methods on the proxy object
      #
      class Proxy < ::Ghee::ResourceProxy
        def collaborators(user=nil, &block)
          prefix = build_prefix user, "collaborators"
          return (!user.is_a?(Hash)) ?  connection.get(prefix).status == 204 : Collaborators::Proxy.new(connection, prefix, user, &block)
        end
      end
    end
  end
end
