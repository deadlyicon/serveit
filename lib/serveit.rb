require 'serveit/version'
require 'pathname'
require 'pry'
require 'rack'
require 'rack/request'
require 'rack/contrib'
require 'active_support/all' # we should be a bit more selective than this
require 'pp'

class Serveit

  def initialize app
    @app = app
  end

  attr_reader :env, :request
  def call env
    @env = env
    @request = Rack::Request.new(@env)
    request.path
    logger.info "#{request.request_method} #{request.path}"
    [200, {'Content-Type' => 'text/plain'}, ['helasdsadsalo world']]
  end

  def logger
    @logger = env['logger'] ||= Logger.new(STDOUT)
  end

end
