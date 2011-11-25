class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    # The Users module handles all of the Github User
    # API endpoints
    #
    module Users

      # Get authenticated user
      #
      # Returns json
      #
      def user
        connection.get('/user').body
      end

      # Get a single user
      #
      # user - String of user login
      #
      # Returns json
      #
      def users(user)
        connection.get("/users/#{user}").body
      end
    end
  end
end