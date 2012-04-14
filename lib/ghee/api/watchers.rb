class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    # The Repos module handles all of the Github Repo
    # API endpoints
    #
    module Repos

      # Proxy inherits from Ghee::Proxy and
      # enables defining methods on the proxy object
      #
      class Proxy < ::Ghee::ResourceProxy
          
        def watchers
          connection.get("#{path_prefix}/watchers").body
        end
      end
    end
    module Users
      class Proxy < ::Ghee::ResourceProxy
        def watched
          connection.get("#{path_prefix}/watched").body
        end
        def watching?(user,repo)
          connection.get("#{path_prefix}/watched/#{user}/#{repo}").status == 204
        end
        def watch(user, repo)
          connection.put("#{path_prefix}/watched/#{user}/#{repo}").status == 204
        end
        def watch!(user, repo)
          connection.delete("#{path_prefix}/watched/#{user}/#{repo}").status == 204
        end
      end
    end
  end
end




