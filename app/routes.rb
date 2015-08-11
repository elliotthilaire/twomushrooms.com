
class App < Sinatra::Base
  get '/' do
    cache_control :no_store # this page is randomly generated, don't cache it

    photos = Photo.find_by_category('featured').shuffle

    @photos = photos[0..11]
    @fadein_photos = photos[12..-1]

    @opengraph = {
      url: url,
      title: 'Two Mushrooms',
      description: 'Photography by Elliott Hilaire',
    }
    @twittercard = { type: 'summary_large_image' }

    erb :index
  end

  get '/gallery' do

    @photos = Photo.find_by_categories(%w(featured gallery)).sort

    @opengraph = {
      url: url,
      title: 'Two Mushrooms gallery',
      description: 'Photos by Elliott',
    }
    @twittercard = { type: 'summary_large_image' }

    erb :gallery
  end

  get '/about' do
    @opengraph = {
      url: url,
      title: 'About',
      description: 'About Elliott',
    }
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
