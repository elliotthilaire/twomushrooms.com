class App < Sinatra::Base
  get '/' do
    cache_control :no_store

    photos = PhotoCollection.featured

    @photos = photos[0..11]
    @fadein_photos = photos[12..-1]

    erb :index
  end

  get '/gallery' do
    @photos = PhotoCollection.gallery
    erb :gallery
  end

  get '/about' do
    erb :about
  end

  get '/:photo' do
    @photo = PhotoCollection.find(params[:photo]) || fail(Sinatra::NotFound)
    erb :photo
  end
end
