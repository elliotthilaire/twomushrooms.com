
require 'sinatra/base'
#require 'sinatra/asset_pipeline'
require 'sinatra/assetpack'
require 'sinatra/partial'
require 'json'
require 'active_support/core_ext/integer/inflections'
require 'sass'
require 'uglifier'

require './photo_model.rb'

# Load Dragonfly configuration
require 'dragonfly'
require './dragonfly/initializer.rb'

require 'dotenv'
Dotenv.load


class App < Sinatra::Base

  set :logging, true
  set :dump_errors, true

  #set :assets_css_compressor, :sass
  #set :assets_js_compressor, :uglifier
  #register Sinatra::AssetPipeline


  # configuration for sinatra-assetpack
  set :root, File.dirname(__FILE__) # You must set app root 

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



  # redirect trailing slashes
  get %r{(.+)/$} do |r|
    redirect r
  end



  get '/' do

    # Don't cache the index page as it's random
    cache_control :no_store

    @selected = :home
    photos = Photo.find_by_category('featured').shuffle
    @photos = photos[0..11]
    @fadein_photos = photos[12..-1]
    erb :index
  end

  get '/gallery' do
    @selected = :gallery
    @photos = Photo.find_by_categories(['featured','gallery'])
    erb :gallery
  end

  get '/about' do
    @selected = :about
    erb :about
  end

  get '/gallery/:photo' do
    @selected = :gallery
    @photo = Photo.find(params[:photo]) || fail(Sinatra::NotFound)
    erb :photo
  end

  not_found do
    erb :not_found
  end

  error do
    erb :error
  end

end
