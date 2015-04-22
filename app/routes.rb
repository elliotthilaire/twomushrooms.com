class App < Sinatra::Base

  # redirect trailing slashes
  get %r{(.+)/$} do |r|
    redirect r
  end

  # redirect from /gallery/blue-ant to /blue-ant
  get '/gallery/:photo' do
    redirect "/#{params[:photo]}"
  end

  get '/' do
   # don't cache index. It's randomly generated
    cache_control :no_store 

    @selected = :home
    photos = Photo.find_by_category('featured').shuffle
    
    @photos = photos[0..11]
    @fadein_photos = photos[12..-1]
    erb :index
  end

  get '/gallery' do
    @selected = :gallery
    @photos = Photo.find_by_categories(['featured','gallery'])
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

  not_found do
     status 404
     erb :not_found
   end

  error do
    erb :error
  end


end
