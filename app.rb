
require 'sinatra/base'
require 'sinatra/asset_pipeline'
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

  set :assets_css_compressor, :sass
  set :assets_js_compressor, :uglifier
  register Sinatra::AssetPipeline

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

  # a route for testing
  get '/image/:size/:image' do |size, image|
    uid = Dragonfly.app.fetch_file("content/featured/#{image}").thumb(size).watermark
    uid.url
  end

end