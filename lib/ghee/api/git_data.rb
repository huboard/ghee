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
          end
        end

        # The Tags module handles all of the tag methods
        #
        module Tags
          class Proxy < ::Ghee::ResourceProxy
          end
        end

        # The Commits module handles all of the commit methods
        #
        module Commits
          class Proxy < ::Ghee::ResourceProxy
          end
        end

        # The Trees module handles all of the commit methods
        #
        module Trees
          class Proxy < ::Ghee::ResourceProxy
          end
        end

        # The Refs module handles all of the commit methods
        #
        module Refs
          class Proxy < ::Ghee::ResourceProxy
          end
        end

        class Proxy < ::Ghee::ResourceProxy

          # Get the blob by a provided sha
          #
          def blobs(sha=nil, params={})
            raise NotImplemented
          end

          # Get a commit by the sha
          #
          def commits(sha=nil, params={})
            raise NotImplemented
          end

          # Get refs for the repo
          #
          def refs(ref=nil)
            raise NotImplemented
          end

          # Get tree by a given sha
          #
          def trees(sha=nil,params={})
            raise NotImplemented
          end

          # Get a tag by a given sha
          #
          def tags(sha=nil)
            raise NotImplemented
          end
        end
      end
      class Proxy < :: Ghee::ResourceProxy

        def git
          raise NotImplemented
        end
      end
    end
  end
end
