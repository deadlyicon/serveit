class Serveit::InferIndex

  def initialize app, options={}
    @app, @options = app, options
  end

  def root
    @root ||= Pathname(@options[:root] || Dir.pwd)
  end

  def call env
    return not_found if File.basename(env['PATH_INFO']) =~ /^index(\.|$)/
    path_info = env['PATH_INFO'].dup
    path = "#{root}#{path_info}"
    env['PATH_INFO'] = File.join(path_info, 'index') if path[-1] == "/"
    # env['PATH_INFO'] = File.join(env['PATH_INFO'], 'index') if File.directory?(path) || path[-1] == "/"
    status, headers, body = @app.call(env)
    if status > 400 &&  File.directory?(path)
      env['PATH_INFO'] = File.join(path_info, 'index')
      status, headers, body = @app.call(env)
    end
    [status, headers, body]
  end

  def not_found
    [404, {'Content-Type' => 'text/plain'}, []]
  end

end
