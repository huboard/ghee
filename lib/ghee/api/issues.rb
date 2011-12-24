class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    # The Issues module handles all of the Github Repo
    # API endpoints
    #
    module Issues

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

      end
    end
  end
end


