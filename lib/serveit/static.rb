require 'rack/file'

class Serveit::Static

  def initialize app, options={}
    @app, @options = app, options
    @file = Rack::File.new root
  end

  def root
    @root ||= Pathname(@options[:root] || Dir.pwd)
  end

  def call env
    # puts "STATIC: #{env['PATH_INFO']}"
    status, headers, body = @file.call(env)
    if status > 400
      @app.call(env)
    else
      [status, headers, body]
    end
  end

end
