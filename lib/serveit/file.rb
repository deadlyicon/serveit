require 'tilt'
require 'rack/mime'

class Serveit::File

  # /a/b/c/people.html.haml.erb
  def initialize path
    @path = Serveit::Path.new(path)
    extensions = @path.extensions
    if extensions.size > 1 && @processor = Tilt[extensions.last.downcase]
      extensions.pop.downcase
    end
    @format = extensions.pop
  end
  attr_reader :path, :processor, :format

  def mime_type
    Rack::Mime.mime_type(".#{format}")
  end

  def controller?
    format == 'rb'
  end

  def template?
    !controller?
  end

  def read
    @path.read
  end

  def render locals={}
    if processor
      processor.new(path.to_s).render(Object.new, locals)
    else
      read
    end
  end

  def inspect
    %(#<#{self.class} path: #{@path}, format: #{format}, processor: #{processor}>)
  end

end
