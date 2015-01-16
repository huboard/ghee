class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    # The Repos module handles all of the Github Repo
    # API endpoints
    #
    module Repos
      # The Contents module handles all of the Github repos file contents
      # API endpoints
      #
      module Contents
        class Proxy < ::Ghee::ResourceProxy
        end
      end

      class Proxy < ::Ghee::ResourceProxy
        def readme(&block)
          block.call(connection) if block
          Contents::Proxy.new connection, "#{path_prefix}/readme"
        end
      end
    end
  end
end
