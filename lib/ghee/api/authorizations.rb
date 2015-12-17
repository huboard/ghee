class Ghee
  module API
    module Authorizations
      class Proxy < ::Ghee::ResourceProxy
        include Ghee::CUD
      end

      def authorizations(number=nil)
        raise NotImplemented
      end
    end
  end
end
