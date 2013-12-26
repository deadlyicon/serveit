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

  def logger
    @logger = self['logger'] ||= Logger.new(STDOUT)
  end

  def responce
    logger.info "#{request_method} #{path}"
    Serveit::Controller.new(self).finish
  end

  def inspect
    %(#<#{self.class} #{request.request_method} #{request.path}>)
  end

end
