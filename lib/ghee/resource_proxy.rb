class Ghee

  # ResourceProxy lets us create a virtual
  # proxy for any API resource, utilizing
  # method_missing to handle passing
  # messages to the real object
  #
  class ResourceProxy

    # Undefine methods that might get in the way
    instance_methods.each { |m| undef_method m unless m =~ /^__|instance_eval|instance_variable_get|object_id/ }

    # Make connection and path_prefix readable
    attr_reader :connection, :path_prefix

    # Instantiates proxy with the connection
    # and path_prefix
    #
    # connection - Ghee::Connection object
    # path_prefix - String
    #
    def initialize(connection, path_prefix)
      @connection, @path_prefix = connection, path_prefix
    end

    # Method_missing takes any message passed
    # to the ResourceProxy and sends it to the
    # real object
    #
    # message - Message object
    # args* - Arguements passed
    #
    def method_missing(message, *args)
      subject.send(message, *args)
    end

    # Subject is the response body parsed
    # as json
    #
    # Returns json
    #
    def subject
      @subject ||= connection.get(path_prefix).body
    end
  end
end