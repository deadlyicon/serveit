require 'mime/types'
require 'rack/file'
require 'tilt'

class Serveit::Controller

  def initialize request
    @request = request
  end
  attr_reader :request

  def inspect
    %(#<#{self.class} #{request.path.to_s.inspect}>)
  end

  def files
    @files ||= begin
      local_path = request.root + request.path.without_extension
      files = Dir[local_path + "index.*"] + Dir["#{local_path}.*"]
      files.map{|path| Serveit::File.new(path) }
    end
  end

  def controller_source_file
    @controller_source_file ||= files.find(&:controller?)
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

  def render
    p files

    if controller_source_file
      instance_eval(controller_source_file.read, controller_source_file.to_s, 1)
    end

    if template
      request.logger.info "Rendering #{template.path}"
      return [200, {'Content-Type' => template.mime_type}, [template.render]]
    end

    # if request.path.local.file?
    #   return Rack::File.new(Serveit.root).call(request.env)
    # end

    return [404, {'Content-Type' => 'text/plain'}, ['404 Not found']]
  end

end
