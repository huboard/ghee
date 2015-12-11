class Ghee
  module API
    module Downloads
      class Proxy < ::Ghee::ResourceProxy

        # Creates
        #
        # return json
        #
        def create(file_path, description="")
          raise NotImplemented
        end

        # Destroys
        #
        # return boolean
        #
        def destroy
          raise NotImplemented
        end
      end
    end

    class Proxy < ::Ghee::ResourceProxy
      def downloads(id=nil)
        raise NotImplemented
      end
    end
  end
end
