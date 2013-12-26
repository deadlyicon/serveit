require 'rack/file'

class Serveit::Static

  def initialize(app)
    @file = Rack::File.new Serveit.root
    @app = app
  end

  def call(env)
    status, headers, body = @file.call(env)
    if status > 400
      @app.call(env)
    else
      [status, headers, body]
    end
  end

end
