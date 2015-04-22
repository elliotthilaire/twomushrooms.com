

# redirects incase I move things around, or change photo names
class App < Sinatra::Base

  # redirect trailing slashes
  get %r{(.+)/$} do |r|
    redirect r
  end

  # redirect from /gallery/blue-ant to /blue-ant
  get '/gallery/:photo' do
    redirect "/#{params[:photo]}"
  end

  not_found do
    status 404
    erb :not_found
  end

  error do
    erb :error
  end

end
