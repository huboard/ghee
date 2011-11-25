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
    end
  end
end