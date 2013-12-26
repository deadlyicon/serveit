require 'rack/file'

class Serveit::Static

  def initialize app, options={}
    @app, @options = app, options
    @file = Rack::File.new root
  end

  def root
    @root ||= Pathname(@options[:root] || Dir.pwd)
  end

  def path
    @env['PATH_INFO']
  end

  def extension?
    File.extname(path) != ""
  end

  def find_file
    if File.extname(@env['PATH_INFO']) == ""
      # TODO make this a default mime type based on accepts
      @env['PATH_INFO'] = @env['PATH_INFO'] + '.html'
    end
    @file.call(@env)
  end

  def call env
    @env = env
    status, headers, body = find_file
    if status > 400
      @app.call(env)
    else
      [status, headers, body]
    end
  end

end
