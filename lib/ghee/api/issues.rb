class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API


    # The Issues module handles all of the Github Repo Issues
    # API endpoints
    #
    module Issues

      # API Comments module handles all of the Github Issues 
      # API endpoints
      #
      module Comments
        class Proxy < ::Ghee::ResourceProxy

          # Creates comment for an issue using the authenicated user
          #
          # return json
          #
          def create(attributes)
            connection.post(path_prefix,attributes).body
          end

          # Patchs and existing comment
          #
          # return json
          #
          def patch(attributes)
            connection.patch(path_prefix, attributes).body
          end

          # Destroys comment by id
          #
          # return boolean
          #
          def destroy
            connection.delete(path_prefix).status == 204
          end
        end
      end

      # Gists::Proxy inherits from Ghee::Proxy and
      # enables defining methods on the proxy object
      #
      class Proxy < ::Ghee::ResourceProxy

        # Create issue
        #
        # attibutes - Hash of attributes to create issue
        #
        # Returns json 
        #
        def create(attributes)
           connection.post(path_prefix,attributes).body
        end

        # Patch issue
        #
        # attributes = Hash of attributes used to update issue
        #
        # returns json
        #
        def patch(attributes)
          connection.patch(path_prefix,attributes).body
        end

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

      end
    end
  end
end


