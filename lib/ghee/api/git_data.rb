class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    # The Repos module handles all of the Github Repo
    # API endpoints
    #
    module Repos

      # The Commits module handles repo commit endpoints
      #
      module Commits
        class Proxy < ::Ghee::ResourceProxy
          include Ghee::CUD
        end
      end

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

        # The Trees module handles all of the commit methods
        #
        module Trees
          class Proxy < ::Ghee::ResourceProxy
            include Ghee::CUD
          end
        end

        # The Refs module handles all of the commit methods
        #
        module Refs
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

          # Get refs for the repo
          #
          def refs(ref=nil)
             prefix = ref ? "#{path_prefix}/refs/#{ref}" : "#{path_prefix}/refs"
            Ghee::API::Repos::Git::Refs::Proxy.new(connection, prefix)
          end

          # Get tree by a given sha
          #
          def trees(sha)
            prefix = "#{path_prefix}/trees/#{sha}"
            Ghee::API::Repos::Git::Trees::Proxy.new(connection, prefix)
          end
        end
      end
    end
  end
end
