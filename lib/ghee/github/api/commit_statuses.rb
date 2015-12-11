class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    # The Repos module handles all of the Github Repo
    # API endpoints
    #
    module Repos
      module Commits
        class Proxy < ::Ghee::ResourceProxy
          undef_method "patch"
          undef_method "destroy"
          undef_method "create"

          def statuses(id=nil, &block)
            prefix = build_prefix id, "statuses"
            Ghee::API::Repos::Commits::Statuses::Proxy.new connection, prefix, id, &block
          end
          def status(&block)
            prefix = build_prefix nil, "status"
            Ghee::API::Repos::Commits::Statuses::Proxy.new connection, prefix, id, &block
          end
        end
        module Statuses
          class Proxy < ::Ghee::ResourceProxy
          end
        end
      end
    end
  end
end

