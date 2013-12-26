class Serveit::InferIndex

  def initialize app, options={}
    @app, @options = app, options
  end

  def root
    @root ||= Pathname(@options[:root] || Dir.pwd)
  end

  def call env
    return not_found if File.basename(env['PATH_INFO']) =~ /^index(\.|$)/
    path = "#{root}#{env['PATH_INFO']}"
    env['PATH_INFO'] = File.join(env['PATH_INFO'], 'index') if File.directory?(path) || path[-1] == "/"
    status, headers, body = @app.call(env)
  end

  def not_found
    [404, {'Content-Type' => 'text/plain'}, []]
  end

end
