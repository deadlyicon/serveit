require 'logger'

class Serveit::Logger
  def initialize app, options={}
    @app = app
    @logger = Logger.new(STDOUT)
  end
  def call env
    env['serveit.logger'] = @logger
    @app.call(env)
  end
end
