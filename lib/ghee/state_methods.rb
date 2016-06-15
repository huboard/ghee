class Ghee
  module CUD

    # Creates 
    #
    # return json
    #
    def create(attributes, &block)
      connection.post(path_prefix,attributes, &block).body
    end

    # Patchs 
    #
    # return json
    #
    def patch(attributes, &block)
      connection.patch(path_prefix, attributes, &block).body
    end

    # Destroys 
    #
    # return boolean
    #
    def destroy(&block)
      connection.delete(path_prefix, &block).status == 204
    end
  end

end
