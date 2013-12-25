require 'logger'

class Serveit::Logger
  def initialize app
    @app = app
    @logger = Logger.new(STDOUT)
  end
  def call env
    env['logger'] = @logger
    @app.call(env)
  end
end
