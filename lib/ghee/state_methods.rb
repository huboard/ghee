class Ghee
  module CUD

    # Creates 
    #
    # return json
    #
    def create(attributes)
      connection.post(path_prefix,attributes).body
    end

    # Patchs 
    #
    # return json
    #
    def patch(attributes)
      connection.patch(path_prefix, attributes).body
    end

    # Destroys 
    #
    # return boolean
    #
    def destroy
      connection.delete(path_prefix).status == 204
    end
  end

end
