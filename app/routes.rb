
class App < Sinatra::Base
  get '/' do
    cache_control :no_store # / is randomly generated, don't cache it
    @selected = :home

    photos = Photo.find_by_category('featured').shuffle

    @photos = photos[0..11]
    @fadein_photos = photos[12..-1]
    erb :index
  end

  get '/gallery' do
    @selected = :gallery
    @photos = Photo.find_by_categories(%w(featured gallery))
    erb :gallery
  end

  get '/about' do
    @selected = :about
    erb :about
  end

  get '/:photo' do
    @selected = :gallery
    @photo = Photo.find(params[:photo]) || fail(Sinatra::NotFound)
    erb :photo
  end
end
