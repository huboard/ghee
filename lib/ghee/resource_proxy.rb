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
    attr_reader :connection, :path_prefix, :params, :current_page, :total

    # Instantiates proxy with the connection
    # and path_prefix
    #
    # connection - Ghee::Connection object
    # path_prefix - String
    #
    def initialize(connection, path_prefix, params = {})
      @connection, @path_prefix, @params = connection, path_prefix, params
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
      @subject ||= connection.get(path_prefix){|req| req.params.merge!params }.body
    end

    # Paginate is a helper method to handle
    # request pagination to the github api
    #
    # options - Hash containing pagination params
    # eg; 
    #     :per_page => 100, :page => 1
    #
    # Returns self
    #
    def paginate(options)
      @current_page = options.fetch(:page) {raise ArgumentError, ":page parameter required"}
      per_page = options.delete(:per_page) || 30
      response = connection.get do |req|
        req.url path_prefix, :per_page => per_page, :page => current_page
        req.params.merge! params
      end

      @subject = response.body

      parse_link_header response.headers.delete("link")

      return self      
    end

    def next_page

    end

    private 

    def parse_link_header(header)
      return @total = subject.size, @pagination = {} if header.nil?
      require 'cgi'
      pattern = /<(?<link>.*)>;\s+rel="(?<rel>.*)"/
      matches = {}
      header.split(',').each do |m|
        match = pattern.match m
        uri = URI.parse(match[:link])
        uri_params = CGI.parse(uri.query)
        matches[match[:rel].to_sym] = match[:link]
      end
      @pagination = matches
    end

  end
end
