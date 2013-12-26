require 'serveit/controller'
require 'serveit/file'

class Serveit::Path < Pathname

  # we ignore absolute paths
  def + path
    super path.to_s.sub(/^\//,'')
  end
  alias_method :join, :+

  alias_method :to_str, :to_s

  def extension
    @extension ||= extname.sub(/^./,'')
  end

  def extensions
    @extensions ||= Array(basename.to_s.split('.')[1..-1])
  end

  def without_extension
    @without_extension ||= self.class.new to_s.sub(%r(#{Regexp.escape(extname)}\Z), '')
  end

end
