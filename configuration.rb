
# Load Dragonfly configuration
require 'dragonfly'
require './dragonfly/initializer.rb'

# load environment variables from file
require 'dotenv'
Dotenv.load

class App < Sinatra::Base

  set :logging, true
  set :dump_errors, true

  # sinatra-assetpack require :root to be configured
  set :root, File.dirname(__FILE__)

  register Sinatra::AssetPack

  assets {
    serve '/js',     from: 'assets/javascripts'        
    serve '/css',    from: 'assets/stylesheets'      
    serve '/images', from: 'assets/images'
    serve '/bower_components', from: 'assets/bower_components'

    # The second parameter defines where the compressed version will be served.
    # (Note: that parameter is optional, AssetPack will figure it out.)
    # The final parameter is an array of glob patterns defining the contents
    # of the package (as matched on the public URIs, not the filesystem)
    
    js :app, '/js/app.js', [
      '/bower_components/jquery/dist/jquery.min.js',
      '/bower_components/bootstrap/dist/js/bootstrap.min.js',
      '/js/application.js'
    ]

    css :app, '/css/app.css', [
      '/bower_components/bootstrap/dist/css/bootstrap.css',
      #'/bower_components/font-awesome/css/font-awesome.css',
      '/css/application.css'
    ]

    js_compression  :jsmin    # :jsmin | :yui | :closure | :uglify
    css_compression :simple   # :simple | :sass | :yui | :sqwish

    prebuild true
  }

  register Sinatra::Partial
  set :partial_template_engine, :erb
  
  # Run Dragonfly as middleware
  use Dragonfly::Middleware

end