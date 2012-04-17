module RelevancePortfolioIterationSwitcher
  class Middleware

    attr_reader :current_iteration, :iterations, :http_auth

    def initialize(app, opts = {})
      @app = app

      @current_iteration = opts[:current_iteration]
      @iterations = opts[:iterations].sort_by { |(iteration_number,link)| iteration_number }
      @http_auth = opts[:http_auth]
    end

    def call(env)
      status, headers, response = @app.call(env)

      response = inject_switcher(response)
      fix_content_length(headers, response)

      [status, headers, response]
    end

    # Helper method for building urls with baked in http auth
    def build_url(url)
      return url unless http_auth

      protocol, uri = detect_protocol(url)
      username, password = [:username, :password].map { |part| CGI.escape http_auth[part] }
      "#{protocol}#{username}:#{password}@#{uri}"
    end

    private

    def detect_protocol(url)
      match = url.match(/^(https?:\/\/)?(.*)$/)
      [match[1], match[2]]
    end

    def fix_content_length(headers, response)
      length = response.to_ary.inject(0) { |len, part| len + part.bytesize }
      headers['Content-Length'] = length.to_s
    end

    def inject_switcher(response)
      body = ""
      response.each {|part| body << part}
      [ body.gsub(/\<body([^\>]*)\>/, "<body\\1>#{iteration_switcher}") ]
    end

    def iteration_switcher
      ERB.new(template).result(binding)
    end

    def root
      Pathname.new(File.expand_path('..', __FILE__))
    end

    def css
      root.join("switcher.css").read
    end

    def template
      root.join("template.erb").read
    end

    def javascript
      root.join("switcher.js").read
    end

  end
end
