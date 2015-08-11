
class App < Sinatra::Base
  get '/' do
    @twittercard = { type: 'summary_large_image' }

    cache_control :no_store # this page is randomly generated, don't cache it

    photos = Photo.find_by_category('featured').shuffle

    @photos = photos[0..11]
    @fadein_photos = photos[12..-1]
    erb :index
  end

  get '/gallery' do
    @twittercard = { type: 'summary_large_image' }

    @photos = Photo.find_by_categories(%w(featured gallery))

    erb :gallery
  end

  get '/about' do
    @twittercard = { type: 'summary' }

    erb :about
  end

  get '/:photo' do
    @photo = Photo.find(params[:photo]) || fail(Sinatra::NotFound)
    @opengraph = {
      url: url,
      title: @photo.title,
      description: 'Photo taken by Elliott Hilaire',
      image: "#{request.base_url}/#{@photo.image.thumb('1200x900').watermark.url}",
    }
    @twittercard = { type: 'summary_large_image' }

    erb :photo
  end
end
