class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    # The Repos module handles all of the Github Repo
    # API endpoints
    #
    module Repos

      # The Git module handles all of the raw git data endpoints
      #
      module Git

        # The Blobs module handles all of the blob methods
        #
        module Blobs
          class Proxy < ::Ghee::ResourceProxy
            include Ghee::CUD
          end
        end

        # The Commits module handles all of the commit methods
        #
        module Commits
          class Proxy < ::Ghee::ResourceProxy
            include Ghee::CUD
          end
        end

        class Proxy < ::Ghee::ResourceProxy

          # Get the blob by a provided sha
          #
          def blobs(sha=nil, params={})
            params = sha if sha.is_a?Hash
            prefix = (!sha.is_a?(Hash) and sha) ? "#{path_prefix}/blobs/#{sha}" : "#{path_prefix}/blobs"
            Ghee::API::Repos::Git::Blobs::Proxy.new(connection, prefix, params)
          end
          
          # Get a commit by the sha
          #
          def commits(sha=nil, params={})
            params = sha if sha.is_a?Hash
            prefix = (!sha.is_a?(Hash) and sha) ? "#{path_prefix}/commits/#{sha}" : "#{path_prefix}/commits"
            Ghee::API::Repos::Git::Commits::Proxy.new(connection, prefix, params)
          end
        end
      end
    end
  end
end
