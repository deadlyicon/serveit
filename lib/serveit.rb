require 'serveit/version'
require 'serveit/request'

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

  def call env
    Serveit::Request.new(env).responce
  end

end
