require 'rack/request'
require 'serveit/path'
require 'rack/file'
require 'pathname'

class Serveit::Request < Rack::Request

  def root
    @root ||= Pathname Dir.pwd
  end

  def path
    @path ||= Serveit::Path.new(self, super)
  end

  def format
    @format ||= path.extension
  end

  def accepts
    @accepts ||= env['rack-accept.request'].media_type.values
    # @accepts ||= begin
    #   accepts = []
    #   accepts << Rack::Mime.mime_type(".#{format}") if format.present?
    #   accepts + env['rack-accept.request'].media_type.values
    # end.uniq
  end

  # def mime_types
  #   @mime_types ||= begin
  #     accepts.map do |mime_type|
  #       MIME::Types[mime_type]
  #     end.flatten(1)
  #   end
  # end

  def responce
    logger.info "#{request_method} #{path}"

    # logger.info controller.pretty_inspect
    # controller
    # logger.info "format: #{format}"
    # logger.info files.pretty_inspect
    # logger.info pretty_inspect
    # logger.into Serveit::Path.new(path)

    logger.info path.local.to_s

    controller.render
  end

  def controller
    @controller ||= Serveit::Controller.new(self)
  end

  def logger
    @logger = self['logger'] ||= Logger.new(STDOUT)
  end

end
