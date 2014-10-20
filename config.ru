require 'dragonfly'
require 'dragonfly/s3_data_store'

require 'dotenv'
Dotenv.load


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

#   datastore :s3,
#    #region: 'us-east-1', 
#    bucket_name: ENV['S3_BUCKET'],
#    access_key_id: ENV['AWS_ACCESS_KEY_ID'],
#    secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
#    url_scheme: 'https',
#    url_host: 's3.amazonaws.com/photography.elliotthilaire.net',
#    fog_storage_options: { path_style: true }

  datastore :file,
    :root_path => 'content/featured/'

end

use Dragonfly::Middleware

require './app.rb'

run Sinatra::Application
