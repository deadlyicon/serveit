ENV['RACK_ENV'] ||= 'development'
ENV['BUNDLE_GEMFILE'] = File.expand_path('../Gemfile', __FILE__)
require 'rubygems'
require 'bundler'
Bundler.require(:default, :development)

require 'serveit'
require 'serveit/logger'
require 'serveit/static'
require 'rack/utils'
require 'rack/request'
require 'rack/response'
require 'rack/lint'
require 'rack/accept'
require 'rack/commonlogger'
require 'rack/showexceptions'

use Rack::CommonLogger, STDERR
use Rack::ShowExceptions
use Rack::Lint
use Rack::Accept
use Serveit::Logger
# use Serveit::Static
use Serveit
run ->(env){ [404, {'Content-Type' => 'text/plain', 'Content-Length' => '3'}, ['404']] }
