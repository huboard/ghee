class Ghee
  module CUD

    # Creates 
    #
    # return json
    #
    def create(attributes)
      connection.post(URI.escape(path_prefix),attributes).body
    end

    # Patchs 
    #
    # return json
    #
    def patch(attributes)
      connection.patch(URI.escape(path_prefix), attributes).body
    end

    # Destroys 
    #
    # return boolean
    #
    def destroy
      connection.delete(URI.escape(path_prefix)).status == 204
    end
  end

end
