class Ghee
  module API
    module Orgs
      class Proxy < ::Ghee::ResourceProxy
        def members(id=nil, &block)
          raise NotImplemented
        end
        def public_members(id=nil, &block)
          raise NotImplemented
        end
      end
      module PublicMembers
        class Proxy < ::Ghee::ResourceProxy
          def check?(username=nil)
            raise NotImplemented
          end

          def add(username=nil)
            raise NotImplemented
          end
          alias_method :publicize, :add

          def remove(username=nil)
            raise NotImplemented
          end
          alias_method :conceal, :remove
        end
      end
      module Members
        class Proxy < ::Ghee::ResourceProxy
          def check?(username=nil)
            raise NotImplemented
          end
        end
      end
    end
  end
end
