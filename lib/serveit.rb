require 'serveit/version'
require 'serveit/request'

require 'pry'
require 'rack'
require 'rack/request'
require 'rack/contrib'
require 'active_support/all' # we should be a bit more selective than this
require 'pp'

class Serveit

  def self.root
    Dir.pwd
  end

  def initialize app, options={}
    @app = app
    @options = options
  end

  def call env
    status, headers, body = Serveit::Request.new(env).responce
    if status == 404
      @app.call(env)
    else
      [status, headers, body]
    end
  end

end
