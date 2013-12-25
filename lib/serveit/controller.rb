class Serveit::Controller

  def initialize request
    @request = request
    # @path = @request.root.join(@request.path.sub(/^\//,''))

  end

end
