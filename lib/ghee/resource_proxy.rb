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
    attr_reader :connection, :path_prefix, :params

    # Expose pagination data
    attr_reader :current_page, :total, :pagination

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
    def method_missing(message, *args, &block)
      subject.send(message, *args, &block)
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

      if @subject.nil?
        @subject = response.body
      else
        @subject = @subject.concat response.body
      end

      parse_link_header response.headers.delete("link")

      return self      
    end

    def all
      return self if pagination && next_page.nil?

      self.paginate :per_page => 100, :page => next_page || 1

      self.all
    end

    # Generate first_page, last_page, next_page, prev_page convienence methods
    %w{ next prev first last }.each do |term|
      define_method "#{term}_page" do
        pagination ? pagination[term.to_sym] ? pagination[term.to_sym][:page] : nil : nil
      end
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
        page = uri_params["page"].first.to_i
        per_page = uri_params["per_page"] ? uri_params["per_page"].first.to_i : 30
        matches[match[:rel].to_sym] = {:link => match[:link], :page => page, :per_page => per_page}
      end
      @pagination = matches
    end

  end
end
