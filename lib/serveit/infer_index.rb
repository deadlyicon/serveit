class Serveit::InferIndex

  def initialize app, options={}
    @app, @options = app, options
  end

  def root
    @root ||= Pathname(@options[:root] || Dir.pwd)
  end

  def path_info
    @path_info ||= @env['PATH_INFO'].dup
  end

  def append_index!
    @env['PATH_INFO'] = File.join(path_info, 'index')
    return @app.call(@env)
  end

  def directory?
    File.directory?("#{root}#{path_info}")
  end

  def call env
    @env = env
    return not_found if File.basename(path_info) =~ /^index(\.|$)/
    return append_index! if path_info[-1] == "/"
    status, headers, body = @app.call(env)
    return [status, headers, body] if status <= 400 || !directory?
    return append_index!
  end

  def not_found
    [404, {'Content-Type' => 'text/plain'}, []]
  end

end
