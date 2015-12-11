class Ghee

  # ResourceProxy lets us create a virtual
  # proxy for any API resource, utilizing
  # method_missing to handle passing
  # messages to the real object
  #
  class ResourceProxy

    # Undefine methods that might get in the way
    instance_methods.each { |m| undef_method m unless m =~ /^__|instance_eval|instance_variable_get|object_id|respond_to|class/ }

    include Ghee::CUD

    # Make connection and path_prefix readable
    attr_reader :connection, :path_prefix, :api_translator, :params, :id

    # Expose pagination data
    attr_reader :current_page, :total, :pagination

    def self.accept_header(header)
      define_method "accept_type" do
        return @_accept_type ||= "#{header}"
      end
    end

  # Instantiates proxy with the connection
  # and path_prefix
  #
  # connection - Ghee::Connection object
  # path_prefix - String
  #
  def initialize(connection, path_prefix, api_translator = nil, params = {}, &block)
    if !params.is_a?Hash
      @id = params
      params = {}
    end
    @connection, @path_prefix, @params = connection, path_prefix, params
    @api_translator = api_translator
    @path_prefix = URI.escape(@path_prefix) if connection.enable_url_escape
    @block = block if block
    subject if block
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

  # Raw is the raw response from the faraday
  # Use this if you need access to status codes
  # or header values
  #
  def raw
    connection.get(path_prefix){|req| req.params.merge!params }
  end

  # Subject is the response body parsed
  # as json
  #
  # Returns json
  #
  def subject
    @subject ||= begin
      response = connection.get(path_prefix) do |req|
        req.params.merge!params
        req.headers["Accept"] = accept_type if self.respond_to? :accept_type
        @block.call(req)if @block
      end

      if @api_translator
        @api_translator.translate_data(response.body)
      else
        response.body
      end
    end
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

  def all_parallel
    connection = @connection.parallel_connection
    headers = connection.head(path_prefix) do |req|
      req.params.merge! params.merge(:per_page => 100)
    end
    pages = pagination_data headers.headers.delete("link")
    requests = []
    connection.in_parallel do
      pages[:pages].to_i.times do |i|
        requests << connection.get(path_prefix) do |req|
          req.params.merge! params.merge(:per_page => 100, :page => i + 1)
        end
      end
    end
    requests.inject([]) do |results, page| 
      results.concat(page.body)
    end
  end

  # Generate first_page, last_page, next_page, prev_page convienence methods
  %w{ next prev first last }.each do |term|
    define_method "#{term}_page" do
      pagination ? pagination[term.to_sym] ? pagination[term.to_sym][:page] : nil : nil
    end
  end

  def build_prefix(first_argument, endpoint)
    (!first_argument.is_a?(Hash) && !first_argument.nil?) ? 
      File.join(path_prefix, "/#{endpoint}/#{first_argument}") : File.join(path_prefix, "/#{endpoint}")
  end

  private 

  def pagination_data(header)
    parse_link_header header
    { pages: @pagination[:last][:page] }
  end


  def parse_link_header(header)
    return @total = subject.size, @pagination = {} if header.nil?
    require 'cgi'
    pattern = /<(.*)>;\s+rel="(.*)"/
    matches = {}
    header.split(',').each do |m|
      match = pattern.match m
      uri = URI.parse(match[1])
      uri_params = CGI.parse(uri.query)
      page = uri_params["page"].first.to_i
      per_page = uri_params["per_page"] ? uri_params["per_page"].first.to_i : 30
      matches[match[2].to_sym] = {:link => match[1], :page => page, :per_page => per_page}
    end
    @pagination = matches
  end

end
end
