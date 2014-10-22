require 'dragonfly'
require 'dragonfly/s3_data_store'
require './dragonfly/watermark_processor'

require 'dotenv'
Dotenv.load

CONTENT_DIRECTORY = ENV['CONTENT_DIRECTORY']

Dragonfly.app.configure do
  
  secret ENV['DRAGONFLY_SECRET']
  
  plugin :imagemagick

  url_format '/media/:job/:name'

  fetch_url_whitelist [          
    /.*/
  ]

  fetch_file_whitelist [
    /.*/
  ]

  datastore :file,
    :root_path => CONTENT_DIRECTORY

  processor :watermark, WatermarkProcessor.new

end

use Dragonfly::Middleware

require './app.rb'

run Sinatra::Application
