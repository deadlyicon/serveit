require 'rack/file'

class Serveit::InferExtension

  def initialize app, options={}
    @app, @options = app, options
  end

  def call env
    status, headers, body = @app.call(env)
    return [status, headers, body] if status <= 400
    path_info = env['PATH_INFO']
    if File.extname(path_info) == ""
      extension = 'html' # TODO make this a default mime type based on accepts
      env['PATH_INFO'] = "#{path_info}.#{extension}"
      status, headers, body = @app.call(env)
    end
    return [status, headers, body]
  end

end
