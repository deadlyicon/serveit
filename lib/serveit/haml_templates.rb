require 'tilt'

class Serveit::HamlTemplates

  def initialize app, options={}
    @app, @options = app, options
  end

  def root
    @root ||= Pathname(@options[:root] || Dir.pwd)
  end

  def path
    @path ||= begin
      path = ".#{@env['PATH_INFO']}"
      path = "#{path}/index" if root.join(path).directory?
      path = path[0..-2]     if path != './' && path[-1] == "/"
      path = "#{path}.html"  if File.extname(path) == ""
      path
    end
  end

  def template_file_path
    @template_file_path ||= root + "#{path}.haml"
  end

  def template_renderable?
    template_file_path.file? && template_file_path.readable?
  rescue SystemCallError
    false
  end

  def template
    @template ||= Tilt.new(template_file_path)
  end

  def render
    @render ||= template.render
  end

  def call env
    @env = env
    return @app.call(@env) unless template_renderable?
    response = Rack::Response.new
    response.status = 200
    response['Content-Type']   = 'text/html'
    response['Content-Length'] = render.length
    response.write render
    response.finish
  end

end
