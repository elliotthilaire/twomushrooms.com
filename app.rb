
require 'sinatra/base'
require 'sinatra/assetpack'
require 'sinatra/partial'
require 'sass'
require 'dragonfly'

require_relative 'app/photo'
require_relative 'app/photo_collection'
require_relative 'app/routes'
require_relative 'app/redirects'
require_relative 'dragonfly/initializer.rb'

# Add to Sass load_path so @import works properly.
Sass.load_paths << 'assets/stylesheets'

class App < Sinatra::Base
  set :logging, true
  set :dump_errors, true

  # run dragonfly as middleware
  # dragonfly listens for image requests and thumbnails / watermarks them
  use Dragonfly::Middleware

  # enable the use of partials
  register Sinatra::Partial
  set :partial_template_engine, :erb

  # sinatra-assetpack require :root to be configured
  set :root, File.dirname(__FILE__)

  # use sinatra-assetpack for
  register Sinatra::AssetPack

  assets do
    serve '/js',     from: 'assets/javascripts'
    serve '/css',    from: 'assets/stylesheets'
    serve '/images', from: 'assets/images'
    serve '/bower_components', from: 'assets/bower_components'

    js :app, '/js/app.js', [
      '/bower_components/jquery/dist/jquery.min.js',
      '/bower_components/bootstrap/dist/js/bootstrap.min.js',
      '/js/*.js'
    ]

    css :app, '/css/app.css', [
      '/bower_components/bootstrap/dist/css/bootstrap.css',
      '/css/main.css'
    ]

    js_compression :jsmin # :jsmin | :yui | :closure | :uglify
    css_compression :sass # :simple | :sass | :yui | :sqwish

    # compile assets when app launched (default is on first request)
    prebuild true
  end
end
