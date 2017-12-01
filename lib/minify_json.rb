class Middleman::Extensions::MinifyJson < Middleman::Extension
  def initialize(*)
    super
    require 'json'
  end

  def ready
    app.use Rack
  end

  class Rack
    extend Memoist
    include Contracts

    # Init
    # @param [Class] app
    # @param [Hash] options
    Contract RespondTo[:call], {} => Any
    def initialize(app, options={})
      @app = app
    end

    # Rack interface
    # @param [Rack::Environmemt] env
    # @return [Array]
    def call(env)
      status, headers, response = @app.call(env)

      content_type = headers['Content-Type'].try(:slice, /^[^;]*/)

      if content_type == 'application/json'
        minified = minify(::Middleman::Util.extract_response_text(response))

        headers['Content-Length'] = minified.bytesize.to_s
        response = [minified]
      end

      [status, headers, response]
    end

    # Minify the content
    # @param [String] content
    # @return [String]
    def minify(content)
      JSON.generate(JSON.parse(content))
    end
    memoize :minify
  end
end

Middleman::Extensions.register(:minify_json) do
  Middleman::Extensions::MinifyJson
end
