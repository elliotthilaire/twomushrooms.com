class App < Sinatra::Base
  get '/' do
    photos = PhotoCollection.featured

    @photos = photos[0..11].shuffle
    @fadein_photos = photos[12..-1]

    erb :index
  end

  get '/gallery/' do
    @photos = PhotoCollection.gallery
    erb :gallery
  end

  get '/about/' do
    erb :about
  end

  get '/:photo/' do
    @photo = PhotoCollection.find(params[:photo]) || fail(Sinatra::NotFound)
    erb :photo
  end
end
