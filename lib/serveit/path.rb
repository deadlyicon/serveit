require 'serveit/controller'
require 'serveit/file'
require 'rack/mime'

class Serveit::Path

  def initialize request, path
    @request, @path = request, Pathname(path[1..-1])
  end
  attr_reader :request

  def to_s
    @path.to_s
  end
  alias_method :to_str, :to_s

  def extension
    @extension ||= File.basename(to_s).split('.').last
  end

  def without_extension
    @without_extension ||= to_s.sub(%r(#{Regexp.escape(File.extname(to_s))}\Z), '')
  end

  def basename
    @basename ||= File.basename(without_extension)
  end

  def local
    @local ||= request.root.join(@path)
  end

  def relative
    path.relative_path_from(request.root)
  end

  def directory?
    local.directory?
  end

  def inspect
    %(#<#{self.class} #{to_s.inspect}>)
  end

end
