require 'rack/request'
require 'serveit/controller'
require 'serveit/path'
require 'serveit/file'
require 'pathname'

class Serveit::Request < Rack::Request

  def root
    @root ||= Pathname Dir.pwd
  end

  def path
    @path ||= Serveit::Path.new(self, super)
  end

  # def format
  #   @format = File.extname(path)[1..-1]
  # end

  def controller
    @controller ||= Serveit::Controller.new(self)
  end

  def responce
    logger.info "#{request_method} #{path}"
    # logger.info controller.pretty_inspect
    # controller
    # logger.info "format: #{format}"
    # logger.info files.pretty_inspect
    # logger.info pretty_inspect
    # logger.into Serveit::Path.new(path)
    logger.info path.files.inspect

    if path.files.empty?
      [404, {'Content-Type' => 'text/plain'}, ['404 Not found']]
    else
      [200, {'Content-Type' => 'text/plain'}, ['helasdsadsalo world']]
    end
  end

  def logger
    @logger = self['logger'] ||= Logger.new(STDOUT)
  end



end
