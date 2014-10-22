require 'dragonfly'
require './dragonfly/watermark_processor'

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
    :root_path => './content/'

  processor :watermark, WatermarkProcessor.new

end

use Dragonfly::Middleware