class Ghee
  module API
    module Orgs
      class Proxy < ::Ghee::ResourceProxy
        def members(id=nil, &block)
          prefix = build_prefix id, "members"
          Ghee::API::Orgs::Members::Proxy.new connection, prefix, nil, id, &block
        end
        def public_members(id=nil, &block)
          prefix = build_prefix id, "public_members"
          Ghee::API::Orgs::PublicMembers::Proxy.new connection, prefix, nil, id, &block
        end
      end
      module PublicMembers
        class Proxy < ::Ghee::ResourceProxy
          def check?(username=nil)
            prefix = username ? File.join(path_prefix, username) : path_prefix
            connection.get(prefix).status == 204
          end

          def add(username=nil)
            prefix = username ? File.join(path_prefix, username) : path_prefix
            connection.put(prefix).status == 204
          end
          alias_method :publicize, :add

          def remove(username=nil)
            prefix = username ? File.join(path_prefix, username) : path_prefix
            connection.delete(prefix).status == 204
          end
          alias_method :conceal, :remove
        end
      end
      module Members
        class Proxy < ::Ghee::ResourceProxy
          def check?(username=nil)
            prefix = username ? File.join(path_prefix, username) : path_prefix
            connection.get(prefix).status == 204
          end
        end
      end
    end
  end
end
