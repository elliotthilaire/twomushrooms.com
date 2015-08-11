
class App < Sinatra::Base
  get '/' do
    cache_control :no_store # this page is randomly generated, don't cache it

    photos = Photo.find_by_category('featured').shuffle

    @photos = photos[0..11]
    @fadein_photos = photos[12..-1]
    erb :index
  end

  get '/gallery' do
    @photos = Photo.find_by_categories(%w(featured gallery))
    erb :gallery
  end

  get '/about' do
    erb :about
  end

  get '/:photo' do
    @photo = Photo.find(params[:photo]) || fail(Sinatra::NotFound)
    @opengraph = {
      url: url,
      title: @photo.title,
      image: "#{request.base_url}/#{@photo.image.thumb('1200x900').watermark.url}",
    }
    erb :photo
  end
end
