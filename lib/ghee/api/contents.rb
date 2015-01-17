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
            if content.nil?
              message.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
              attributes = { path: path }.merge message
              attributes[:content] = Base64.encode64 attributes[:content]
            else
              attributes = {
                path: path,
                message: message, 
                content: Base64.encode64(content)
              }
            end
            connection.put(path_prefix, attributes).body
          end
        end
      end

      class Proxy < ::Ghee::ResourceProxy
        def contents(path, &block)
          proxy = Contents::Proxy.new connection, "#{path_prefix}/contents/#{path}", nil, &block
          proxy.path = path
          proxy
        end
        def readme(&block)
          Contents::Proxy.new connection, "#{path_prefix}/readme", {}, &block
        end
      end
    end
  end
end
