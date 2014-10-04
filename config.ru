require 'dragonfly'

Dragonfly.app.configure do
 
  secret 'This is my secret yeh!!' 
  plugin :imagemagick
  url_format '/media/:job/:name'

  fetch_url_whitelist      [          # List of allowed urls when using fetch_url (strings or regexps)
    /.*/
  ]

  fetch_file_whitelist [
    /.*/
  ]

end

use Dragonfly::Middleware

require './app.rb'

run Sinatra::Application
