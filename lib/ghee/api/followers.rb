class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    module Users
      class Proxy < ::Ghee::ResourceProxy
        def followers
          raise NotImplemented
        end
        def following
          raise NotImplemented
        end
        def following?(user)
          raise NotImplemented
        end
        def follow(user)
          raise NotImplemented
        end
        def follow!(user)
          raise NotImplemented
        end
      end
    end
  end
end



