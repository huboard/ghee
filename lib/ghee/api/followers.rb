class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    module Users
      class Proxy < ::Ghee::ResourceProxy
        def followers
          connection.get("#{path_prefix}/followers").body
        end
        def following
          connection.get("#{path_prefix}/following").body
        end
        def following?(user)
          connection.get("#{path_prefix}/following/#{user}").status == 204
        end
        def follow(user)
          connection.put("#{path_prefix}/following/#{user}").status == 204
        end
        def follow!(user)
          connection.delete("#{path_prefix}/following/#{user}").status == 204
        end
      end
    end
  end
end



