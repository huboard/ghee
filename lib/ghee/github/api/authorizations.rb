class Ghee
  module API
    module Authorizations
      class Proxy < ::Ghee::ResourceProxy
        include Ghee::CUD
      end

      def authorizations(number=nil)
        prefix = number ? "./authorizations/#{number}" : "./authorizations"
        Ghee::API::Authorizations::Proxy.new(connection, prefix)
      end
    end
  end
end
