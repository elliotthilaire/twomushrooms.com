require 'dragonfly'
require 'dragonfly/s3_data_store'

require 'dotenv'
Dotenv.load

require './watermark'


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
    :root_path => 'content/'

  processor :watermark, WatermarkProcessor.new

end

# ... other initialization stuff above here ...
#Dragonfly[:images].processor.register(Watermark)
# optional, but gives you the ability to use watermark(opacity: 50)
# rather than process(:watermark, opacity: 50)
#Dragonfly[:images].configure do |c|
#  c.job(:watermark) { |*args| process(:watermark, *args) }
#end

use Dragonfly::Middleware

require './app.rb'

run Sinatra::Application
