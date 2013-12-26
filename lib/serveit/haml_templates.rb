require 'tilt'

class Serveit::HamlTemplates

  def initialize app, options={}
    @app, @options = app, options
  end

  def root
    @root ||= Pathname(@options[:root] || Dir.pwd)
  end

  def call env
    dup._call env
  end

  def _call env
    @env = env
    # p path
    return not_found if path =~ /\.haml$/
    if renderable?
      body = Tilt.new(path).render
      [200, {'Content-Type' => 'text/html', 'Content-Length' => body.length.to_s}, [body]]
    else
      @app.call(@env)
    end
  end

  def path
    @path ||= root.join(".#{@env['PATH_INFO']}").to_s
  end

  def renderable?
    return false if path !~ /\.html$/
    path << '.haml' if $1.nil?
    File.file?(path) && File.readable?(path)
  rescue SystemCallError
    false
  end

  def not_found
    [404, {'Content-Type' => 'text/plain'}, []]
  end

end
