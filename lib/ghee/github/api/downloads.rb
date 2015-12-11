class Ghee
  module API
    module Downloads
      class Proxy < ::Ghee::ResourceProxy

        # Creates 
        #
        # return json
        #
        def create(file_path, description="")
          params = {
            :name => File.basename(file_path),
            :size => File.size(file_path),
            :description => description
          }
          download = connection.post(path_prefix, params).body
          s3 = Faraday.new(:url => download["s3_url"]) do |builder|
            builder.request  :multipart
            builder.request  :url_encoded

            builder.adapter  :net_http
          end
          upload = {
            :key => download["path"],
            :acl => download["acl"],
            :success_action_status => 201,
            :Filename => download["name"],
            :AWSAccessKeyId => download["accesskeyid"],
            :Policy => download["policy"],
            :Signature => download["signature"],
            :"Content-Type" => download["mime_type"],
            :file => Faraday::UploadIO.new(file_path, download["mime_type"])
          }
          s3.post("/",upload).status == 201
          return download 
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

    class Proxy < ::Ghee::ResourceProxy
      def downloads(id=nil)
        prefix = id ?  "#{path_prefix}/downloads/#{id}" :"#{path_prefix}/downloads"
        Ghee::API::Downloads::Proxy.new(connection, prefix)
      end
    end
  end
end
