
class App < Sinatra::Base
  get '/' do
    cache_control :no_store

    photos = PhotoCollection.featured

    @photos = photos[0..11]
    @fadein_photos = photos[12..-1]

    @opengraph = {
      url: "http://twomushrooms.com#{request.path}",
      title: 'Two Mushrooms',
      description: 'Photography by Elliott Hilaire',
      image: 'http://twomushrooms.com/site-preview.jpg'
    }
    @twittercard = { type: 'summary_large_image' }

    erb :index
  end

  get '/gallery' do
    @photos = PhotoCollection.gallery

    @opengraph = {
      url: "http://twomushrooms.com#{request.path}",
      title: 'Two Mushrooms gallery',
      description: 'Photos by Elliott',
      image: 'http://twomushrooms.com/site-preview.png'
    }
    @twittercard = { type: 'summary_large_image' }

    erb :gallery
  end

  get '/about' do
    @opengraph = {
      url: "http://twomushrooms.com#{request.path}",
      title: 'About',
      description: 'About Elliott',
      image: 'http://twomushrooms.com/site-preview.png'
    }
    @twittercard = { type: 'summary' }

    erb :about
  end

  get '/:photo' do
    @photo = PhotoCollection.find(params[:photo]) || fail(Sinatra::NotFound)

    @opengraph = {
      url: "http://twomushrooms.com#{request.path}",
      title: @photo.title,
      description: 'Photo taken by Elliott Hilaire',
      image: "http://twomushrooms.com#{@photo.image.thumb('1200x900').watermark.url}"
    }
    @twittercard = { type: 'summary_large_image' }

    erb :photo
  end
end
