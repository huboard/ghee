class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API


    # The Issues module handles all of the Github Repo Issues
    # API endpoints
    #
    module Issues

      # API labels module handles all of the Github Issues 
      # API endpoints
      #
      module Labels
        class Proxy < ::Ghee::ResourceProxy

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
          include Ghee::CUD
        end
      end

      # Gists::Proxy inherits from Ghee::Proxy and
      # enables defining methods on the proxy object
      #
      class Proxy < ::Ghee::ResourceProxy
        include Ghee::CUD

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

        def comments(id=nil)
          prefix = id ? "#{path_prefix}/comments/#{id}" : "#{path_prefix}/comments"
          Ghee::API::Issues::Comments::Proxy.new(connection,prefix)
        end

        def labels
          Ghee::API::Issues::Labels::Proxy.new(connection, "#{path_prefix}/labels")
        end

      end
    end
  end
end


