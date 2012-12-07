class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    module Repos

      # The Issues module handles all of the Github Repo Issues
      # API endpoints
      #
      module Issues

        # API labels module handles all of the Github Issues 
        # API endpoints
        #
        module Labels
          class Proxy < ::Ghee::ResourceProxy
            undef_method "patch"
            undef_method "destroy"
            undef_method "create"

            # Creates label for an issue using the authenicated user
            #
            # labels - Array of labels
            #
            # return json
            #
            def add(labels)
              connection.post(path_prefix,labels).body
            end

            # Patchs and existing label
            #
            # return json
            #
            def replace(labels)
              connection.put(path_prefix, labels).body
            end

            # Destroys label by id
            #
            # return boolean
            #
            def remove
              connection.delete(path_prefix).status == 204
            end
          end
        end

        # API Comments module handles all of the Github Issues 
        # API endpoints
        #
        module Comments
          class Proxy < ::Ghee::ResourceProxy
          end
        end

        module Events
          class Proxy < ::Ghee::ResourceProxy
            undef_method "patch"
            undef_method "destroy"
            undef_method "create"
          end
        end

        # Gists::Proxy inherits from Ghee::Proxy and
        # enables defining methods on the proxy object
        #
        class Proxy < ::Ghee::ResourceProxy

          # Close issue - closed issue by id
          #
          # usage - ghee.repos("my_repo").issues(1).close
          #
          # returns boolean
          #
          def close
            connection.patch(path_prefix,:state => "closed").body["state"] == "closed"
          end

          # Returns closed issues
          #
          # Returns json
          #
          def closed
            response = connection.get path_prefix do |req|
              req.params["state"] = "closed"
            end
            response.body
          end

          # Returns issue comments for an issue or all of the comments 
          # for a repo
          def comments(id=nil)
            prefix = id ? "#{path_prefix}/comments/#{id}" : "#{path_prefix}/comments"
            Ghee::API::Repos::Issues::Comments::Proxy.new(connection,prefix)
          end

          # Returns all of the labels for repo
          #
          def labels
            Ghee::API::Repos::Issues::Labels::Proxy.new(connection, "#{path_prefix}/labels")
          end

          # Returns issue events for a repo or issue number
          #
          def events(id=nil)
            prefix = id ? "#{path_prefix}/events/#{id}" : "#{path_prefix}/events"
            Ghee::API::Repos::Issues::Events::Proxy.new(connection,prefix)
          end

        end
      end

      class Proxy < ::Ghee::ResourceProxy

        # Get issues
        #
        # Returns json
        #
        def issues(number=nil)
          prefix = (!number.is_a?(Hash) and number) ? "#{path_prefix}/issues/#{number}" : "#{path_prefix}/issues"
          Ghee::API::Repos::Issues::Proxy.new(connection, prefix, number)
        end
      end
    end
  end
end


