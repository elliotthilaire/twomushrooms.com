
require 'sinatra'
require 'json'
require 'active_support/core_ext/integer/inflections'
require 'dragonfly'

require './helpers.rb'

require './photo_model.rb'
require './photo_presenter.rb'

require 'dotenv'
Dotenv.load

set :logging, true
set :dump_errors, true

#redirect trailing slashes
get %r{(.+)/$} do |r| 
  redirect r
end

get '/' do

  cache_control :no_store 

  @selected = :home

  thumbnails = []
  photos = PhotoPresenter.wrap(Photo.all.shuffle)

  photos.each do |photo|
    thumbnails << {:url => photo.image.thumb('300x200#').url, :slug => photo.slug}
  end
  
  @thumbnails = thumbnails.to_json
  @photos = photos[0 .. 11]

  erb :index
end

get "/gallery" do
  @selected = :gallery
  @photos = PhotoPresenter.wrap(Photo.all)
  erb :gallery
end

get "/about" do
 @selected = :about
 erb :about
end

get "/gallery/:photo" do
  @selected = :gallery
  @photo = PhotoPresenter.new(Photo.find(params[:photo])) || raise(Sinatra::NotFound)
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
 
