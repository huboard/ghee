class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    # The Events module handles all of the Github Event
    # API endpoints
    #
    module Events

      # Get events
      #
      # Returns json
      #
      def events
        connection.get('/events').body
      end
    end
  end
end