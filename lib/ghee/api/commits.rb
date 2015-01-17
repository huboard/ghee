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
            Comments::Proxy.new connection, path_prefix
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

      # Repos::Proxy inherits from Ghee::Proxy and
      # enables defining methods on the proxy object
      #
      class Proxy < ::Ghee::ResourceProxy
        def compare(base, head)
          connection.get("#{path_prefix}/compare/#{base}...#{head}").body
        end
        def commits(sha=nil, &block)
          prefix = build_prefix sha, "commits"
          Commits::Proxy.new(connection, prefix, sha, &block)
        end
        def comments(id=nil, &block)
          prefix = build_prefix id, "comments"
          Comments::Proxy.new connection, prefix, id, &block
        end
      end
    end
  end
end


