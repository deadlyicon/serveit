class Serveit::Path

  def initialize request, path
    @request, @path = request, path
    @path = @path+'index' if @path[-1] == '/'
  end

  def to_s
    @path.to_s
  end
  alias_method :to_str, :to_s

  def extension
    @extension ||= File.extname(@path)[1..-1].presence || 'html' # TODO respect accepts header
  end

  def without_extension
    @without_extension ||= @path.sub(%r(#{Regexp.escape(File.extname(@path))}\Z), '')
  end

  def basename
    @basename or begin
      @basename = File.basename(without_extension)
      @basename = @basename + 'index' if @basename[-1] == '/'
    end
    @basename
  end

  def files
    @request.logger.info "searching for: #{@request.root}#{without_extension}.*"
    Dir["#{@request.root}#{without_extension}.*"]
  end

  def inspect
    %(#<#{self.class} #{@path.inspect}>)
  end

end
