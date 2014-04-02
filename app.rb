require "rubygems"
require "bundler"
#Bundler.require

require 'sinatra'
require 'haml'
require 'json'
require './sinatra-thumbnails/lib/sinatra/thumbnails.rb'
require 'active_support/core_ext/integer/inflections'

require 'pony'

load 'models.rb'
load 'helpers.rb'

set :logging, true
set :dump_errors, true


get '/' do
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

post '/contact' do 

    Pony.mail(
      :from => "<smtp.elliott.hilaire@gmail.com>",
      :to => 'elliott.hilaire@gmail.com',
      :subject => "[Photography] #{params[:email]}",
      :body => params[:message],
#      :port => '587',
#      :via => :smtp,
#      :via_options => { 
#        :address              => 'smtp.gmail.com', 
#        :port                 => '587', 
#        :enable_starttls_auto => true, 
#        :user_name            => 'smtp.elliott.hilaire@gmail.com', 
#        :password             => 'fingerbuns', 
#        :authentication       => :plain, 
#        :domain               => 'localhost.localdomain'
#      }
)
end


get "/:photo" do
  @photo = Photo.find(params[:photo]) || raise(Sinatra::NotFound)
  erb :photo
end

not_found do
  erb :not_found
end

error do
  erb :error
  #env['sinatra.error'].name
end

#get "/blog" do
#  @posts = Post.all
#  erb :posts
#end

#get "/blog/:slug" do
#  @post = Post.find(params[:slug]) || raise(Sinatra::NotFound)
#  erb :post
#end

#get "/content/*" do
# file = "content/" + params[:splat].first
# send_file file
#end
 
