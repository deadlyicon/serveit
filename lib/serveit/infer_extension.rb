class Serveit::InferExtension

  def initialize app, options={}
    @app, @options = app, options
  end

  def call env
    status, headers, body = @app.call(env)
    return [status, headers, body] if status <= 400
    path = env['PATH_INFO']
    if File.basename(path) != 'index' && File.extname(path) == ""
    # if File.extname(path) == ""
      extension = 'html' # TODO make this a default mime type based on accepts
      env['PATH_INFO'] << ".#{extension}"
      status, headers, body = @app.call(env)
    end
    return [status, headers, body]
  end

end
