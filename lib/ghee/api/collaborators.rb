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

      # Gists::Proxy inherits from Ghee::Proxy and
      # enables defining methods on the proxy object
      #
      class Proxy < ::Ghee::ResourceProxy
        def collaborators(user=nil)
          prefix = user ? "#{path_prefix}/collaborators/#{user}" : "#{path_prefix}/collaborators"
          return user ?  connection.get(prefix).status == 204 : Ghee::API::Repos::Collaborators::Proxy.new(connection, prefix)
        end
      end

    end
  end
end
