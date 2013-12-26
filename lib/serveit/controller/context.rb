# class Serveit::Controller::Context

#   def initialize controller, file
#     @controller = controller
#     instance_eval(file.read, file.path.to_s, 1) if file
#     implcit_render unless rendered?
#   end
#   attr_reader :controller

#   delegate *%w{
#     request
#     response
#     locals
#     headers
#   }, to: :controller

#   def render template, locals
#   end

#   def implcit_render
#     render
#   end


#   # if template
#   #   headers['Content-Type'] = template.mime_type
#   #   request.logger.info "Rendering #{template.path}"
#   #   p locals
#   #   body = template.render(locals)
#   #   request['Content-Length'] = body.length
#   #   return [200, headers, [body]]
#   # end



#   def files
#     @files ||= begin
#       local_path = request.root + request.path.without_extension
#       files = Dir[local_path + "index.*"] + Dir["#{local_path}.*"]
#       files.map{|path| Serveit::File.new(path) }
#     end
#   end


# end
