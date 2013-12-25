require "serveit/version"
require 'pry'
require 'rack'
require 'active_support/all' # we should be a bit more selective than this

class Serveit
  def self.run!
    new.run!
  end

  def initialize
  end

  def run!
    puts "Running at http://#{host}:#{port}"
    Rack::Server.start(app: self, :Port => port)
  end

  def call env
    [200, {}, ['hello']]
  end

  def host
    '127.0.0.1'
  end

  def port
    @port ||= begin
      server = TCPServer.new(host, 0)
      server.addr[1]
    ensure
      server.close if server
    end
  end

end
