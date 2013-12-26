require 'rack/request'
require 'serveit/path'
require 'rack/file'
require 'pathname'

class Serveit::Request < Rack::Request

  autoload :Path, 'serveit/request/path'

  def root
    @root ||= Serveit::Path.new(Dir.pwd)
  end

  def path
    @path ||= Path.new(super)
  end

  def format
    @format ||= path.extension
  end

  def accepts
    @accepts ||= env['rack-accept.request'].media_type.values
  end

  def responce
    logger.info "#{request_method} #{path}"

    # logger.info controller.pretty_inspect
    # controller
    # logger.info "format: #{format}"
    # logger.info files.pretty_inspect
    # logger.info pretty_inspect
    # logger.into Serveit::Path.new(path)

    # logger.info path.local.to_s

    controller.render
  end

  def controller
    @controller ||= Serveit::Controller.new(self)
  end

  def logger
    @logger = self['logger'] ||= Logger.new(STDOUT)
  end

end
