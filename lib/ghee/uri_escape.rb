class Ghee
  module Middleware
    class UriEscape < Faraday::Middleware
      def call(env)

        env[:url] = URI.parse(URI.escape(env[:url].to_s))
        @app.call(env)
      end
    end
  end
end
