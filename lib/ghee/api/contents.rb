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
          attr_accessor :path
          def create(message, content=nil)
            raise NotImplemented
          end
        end
      end

      class Proxy < ::Ghee::ResourceProxy
        def contents(path, &block)
          raise NotImplemented
        end
        def readme(&block)
          raise NotImplemented
        end
      end
    end
  end
end
