class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    module Users
      module Emails
        class Proxy < ::Ghee::ResourceProxy

          def add(emails)
            raise NotImplemented
          end

          def remove(emails)
            raise NotImplemented
          end
        end
      end
      class Proxy < ::Ghee::ResourceProxy
        def emails
          raise NotImplemented
        end
      end
    end
  end
end


