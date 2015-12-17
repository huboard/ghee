class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    module Repos

      module Assignees
        class Proxy < ::Ghee::ResourceProxy
          def check?(member)
            raise NotImplemented
          end
        end
      end
      class Proxy < ::Ghee::ResourceProxy
        def assignees
          raise NotImplemented
        end
      end

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
              raise NotImplemented
            end

            # Patchs and existing label
            #
            # return json
            #
            def replace(labels)
              raise NotImplemented
            end

            # Destroys label by id
            #
            # return boolean
            #
            def remove
              raise NotImplemented
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
          end
        end

        # Gists::Proxy inherits from Ghee::Proxy and
        # enables defining methods on the proxy object
        #
        class Proxy < ::Ghee::ResourceProxy
          attr_accessor :repo

          # Close issue - closed issue by id
          #
          # usage - ghee.repos("my_repo").issues(1).close
          #
          # returns boolean
          #
          def close
            raise NotImplemented
          end

          # Returns closed issues
          #
          # Returns json
          #
          def closed
            raise NotImplemented
          end

          # Returns issue comments for an issue or all of the comments
          # for a repo
          def comments(id=nil)
            raise NotImplemented
          end

          # Returns all of the labels for repo
          #
          def labels
            raise NotImplemented
          end

          # Returns issue events for a repo or issue number
          #
          def events(id=nil)
            raise NotImplemented
          end

        end
      end

      class Proxy < ::Ghee::ResourceProxy


        # Get issues
        #
        # Returns json
        #
        def issues(number=nil)
          raise NotImplemented
        end
      end
    end
  end
end


