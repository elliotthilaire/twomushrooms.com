require 'sinatra/base'
require 'sinatra/partial'
require 'dragonfly'

require_relative 'app/photo'
require_relative 'app/photo_collection'
require_relative 'app/routes'
require_relative 'app/redirects'
require_relative 'dragonfly/initializer.rb'

class App < Sinatra::Base
  set :logging, true
  set :dump_errors, true

  # run dragonfly as middleware
  # dragonfly listens for image requests and thumbnails / watermarks them
  use Dragonfly::Middleware

  # enable the use of partials
  register Sinatra::Partial
  set :partial_template_engine, :erb

  set :root, File.dirname(__FILE__)
end
