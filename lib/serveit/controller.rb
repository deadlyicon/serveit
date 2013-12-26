require 'mime/types'
require 'rack/response'
require 'rack/file'
require 'tilt'

class Serveit::Controller


  def initialize request
    @request = request
    eval_controller_file!
  end
  attr_reader :request

  def locals
    @locals ||= {}
  end

  def response
    @response ||= Rack::Response.new
  end

  def finish
    response.finish
  end



  def files
    @files ||= begin
      local_path = request.root + request.path.without_extension
      files = Dir[local_path + "index.*"] + Dir["#{local_path}.*"]
      files.map{|path| Serveit::File.new(path) }
    end
  end

  def controller_file
    @controller_file ||= files.find{|file| file.extension == 'rb' }
  end

  def eval_controller_file!
    return unless controller_file
    instance_eval(controller_file.read, controller_file.path.to_s, 1)
  end

  def template
    return @template if defined? @template
    if request.format.present?
      mime_type = Rack::Mime.mime_type(".#{request.format}")
      files.each do |file|
        return @template = file if Rack::Mime.match?(file.mime_type, mime_type)
      end
    else
      request.accepts.each do |mime_type|
        files.each do |file|
          return @template = file if Rack::Mime.match?(file.mime_type, mime_type)
        end
      end
    end
    @template
  end

  def execute_controller!
    Context.new(self, files.find(&:controller?))
  end

  def render
    execute_controller!
    response.finish

    # if request.path.local.file?
    #   return Rack::File.new(Serveit.root).call(request.env)
    # end

    return [404, {'Content-Type' => 'text/plain'}, ['404 Not found']]
  end


  def inspect
    %(#<#{self.class}>)
  end

end
