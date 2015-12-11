class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    module Repos

      # The Milestones module handles all of the Github Repo Milestones
      # API endpoints
      #
      module Milestones


        # Gists::Proxy inherits from Ghee::Proxy and
        # enables defining methods on the proxy object
        #
        class Proxy < ::Ghee::ResourceProxy
          include Ghee::CUD

          # Close milestone - closed milestone by id
          #
          # usage - ghee.repos("my_repo").milestones(1).close
          #
          # returns boolean
          #
          def close
            connection.patch(path_prefix,:state => "closed").body["state"] == "closed"
          end

          # Returns closed milestones
          #
          # Returns json
          #
          def closed
            response = connection.get path_prefix do |req|
              req.params["state"] = "closed"
            end
            response.body
          end

        end
      end

      # Gists::Proxy inherits from Ghee::Proxy and
      # enables defining methods on the proxy object
      #
      class Proxy < ::Ghee::ResourceProxy

        # Get milestones
        #
        # Returns json
        #
        def milestones(number=nil, params={})
          params = number if number.is_a?Hash
          prefix = (!number.is_a?(Hash) and number) ? "#{path_prefix}/milestones/#{number}" : "#{path_prefix}/milestones"
          Ghee::API::Repos::Milestones::Proxy.new(connection, prefix, params)
        end
      end
    end
  end
end


