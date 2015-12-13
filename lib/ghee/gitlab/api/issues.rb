class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API
    module Repos

      module Assignees
        class Proxy < ::Ghee::ResourceProxy
          def check?(member)
            connection.get("#{path_prefix}/#{member}").status == 204
          end
        end
      end
      class Proxy < ::Ghee::ResourceProxy
        def assignees
          prefix = "#{path_prefix}/assignees"
          Ghee::API::GitLab::Repos::Assignees::Proxy.new(connection, prefix)
        end
      end

      # The Issues module handles all of the GitLab Repo Issues
      # API endpoints
      #
      module Issues

        # API labels module handles all of the GitLab Issues
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

        # API Comments module handles all of the GitLab Issues
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
          attr_accessor :repo

          # Close issue - closed issue by id
          #
          # usage - ghee.repos("my_repo").issues(1).close
          #
          # returns boolean
          #
          def close
            connection.put(path_prefix, :state_event => "closed").status = 200
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
            return [] if id.nil?
            prefix = id ? "#{path_prefix}/notes/#{id}" : "#{path_prefix}/notes"
            Ghee::API::GitLab::Repos::Issues::Comments::Proxy.new(connection,prefix)
          end

          # Returns all of the labels for repo
          #
          def labels
            # Not supported yet: GitLab needs to retrieve by repo_path instead of issues/repo_path
            raise NotImplemented
          end

          # Returns issue events for a repo or issue number
          #
          def events(id=nil)
            # Not supported yet: GitLab system notes do not have metadata
            raise NotImplemented
          end

        end
      end

      class Proxy < ::Ghee::ResourceProxy
        attr_accessor :issue_path

        # Get issues
        #
        # Returns json
        #
        def issues(number=nil)
          prefix = (!number.is_a?(Hash) and number) ? "#{path_prefix}/issues/#{number}" : "#{path_prefix}/issues"
          issue = Ghee::API::Repos::Issues::Proxy.new(connection, prefix, ::Ghee::GitLab::IssueTranslator.new(:issue))
          issue.repo = self
          issue
        end
      end
    end
  end
end
