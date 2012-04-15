class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    module Users
      module Emails
        class Proxy < ::Ghee::ResourceProxy

          def add(emails)
            connection.post(path_prefix, emails).body
          end

          def remove(emails)
            connection.delete(path_prefix) do |req|
              req.body = emails
            end.status == 204
          end
        end
      end
      class Proxy < ::Ghee::ResourceProxy
        def emails
          Ghee::API::Users::Emails::Proxy.new connection, "#{path_prefix}/emails"
        end
      end
    end
  end
end


