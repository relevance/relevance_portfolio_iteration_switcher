module RelevancePortfolioIterationSwitcher
  class Middleware

    attr_reader :current_iteration, :iterations

    def initialize(app, opts = {})
      @app = app

      @current_iteration = opts[:current_iteration]
      @iterations = opts[:iterations].sort_by { |(iteration_number,link)| iteration_number }
    end

    def call(env)
      status, headers, response = @app.call(env)

      response = inject_switcher(response)
      fix_content_length(headers, response)

      [status, headers, response]
    end

    private

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
