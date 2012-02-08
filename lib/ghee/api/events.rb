class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    # The Events module handles all of the Github Event
    # API endpoints
    #
    module Events
      class Proxy < ::Ghee::ResourceProxy
      end

      # Get events
      #
      # Returns json
      #
      def events(params={})
        return Proxy.new(connection, "/events",params)
      end
      
    end
  end
end
