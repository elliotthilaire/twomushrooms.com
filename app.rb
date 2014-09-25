require 'rubygems'
require 'bundler/setup'

require 'sinatra'
require 'json'
require './sinatra-thumbnails/lib/sinatra/thumbnails.rb'
require 'active_support/core_ext/integer/inflections'

load 'models.rb'
load 'helpers.rb'

set :logging, true
set :dump_errors, true

get '/' do

  cache_control :no_store 

  @selected = :home

  thumbnails = []
  photos = Photo.all.shuffle

  photos.each do |photo|
    thumbnails << {:url => thumbnail_url_for(photo.url, "300x200-crop"), :stub => photo.name}
  end
  
  @thumbnails = thumbnails.to_json
  @photos = photos[0 .. 11]

  erb :index
end

get "/gallery" do
  @selected = :gallery
  @photos = Photo.all
  erb :gallery
end

get "/about" do
 @selected = :about
 erb :about
end

get "/gallery/:photo" do
  @selected = :gallery
  @photo = Photo.find(params[:photo]) || raise(Sinatra::NotFound)
  erb :photo
end

get "/gallery/" do
  redirect '/gallery'
end

get "/about/" do
  redirect '/about'
end

get "/:slug" do
  @photo = Photo.find(params[:slug]) || raise(Sinatra::NotFound)
  erb :photo
end

not_found do
  erb :not_found
end

error do
  erb :error
  #env['sinatra.error'].name
end

#get "/content/*" do
# file = "content/" + params[:splat].first
# send_file file
#end
 
