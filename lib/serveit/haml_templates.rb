class Serveit::HamlTemplates

  def initialize app, options={}
    @app, @options = app, options
  end

  def call env
    # look at the request path and the accepts header
    # if a haml file matches render it and return it
    @app.call(env)
  end

end
