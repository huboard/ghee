class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    # The Repos module handles all of the Github Repo
    # API endpoints
    #
    module Repos

      module Commits
        class Proxy < ::Ghee::ResourceProxy

          def comments
            Ghee::API::Repos::Commits::Comments::Proxy.new connection, path_prefix
          end
        end

        module Comments
          class Proxy < ::Ghee::ResourceProxy

            def create(attributes)
              connection.post(path_prefix, attributes).body
            end
          end
        end
      end

      module Comments
        class Proxy < ::Ghee::ResourceProxy

          def patch(attibutes)
            connection.patch(path_prefix, attibutes).body
          end

          def destroy
            connection.delete(path_prefix).status == 204
          end

        end
      end

      # Gists::Proxy inherits from Ghee::Proxy and
      # enables defining methods on the proxy object
      #
      class Proxy < ::Ghee::ResourceProxy
        def compare(base, head)
          connection.get("#{path_prefix}/compare/#{base}...#{head}").body
        end
        def commits(sha=nil, params={})
          params = sha if sha.is_a?Hash
          prefix = (!sha.is_a?(Hash) and sha) ? "#{path_prefix}/commits/#{sha}" : "#{path_prefix}/commits"
          Ghee::API::Repos::Commits::Proxy.new(connection, prefix, params)
        end
        def comments(id=nil)
          prefix = id ? "#{path_prefix}/comments/#{id}" : "#{path_prefix}/comments"
          Ghee::API::Repos::Comments::Proxy.new connection, prefix
        end
      end
    end
  end
end


