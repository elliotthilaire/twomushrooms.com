require 'dragonfly'
require './dragonfly/watermark_processor'
require './dragonfly/orientation_analyser'

Dragonfly.app.configure do

  response_header 'Cache-Control', 'public, max-age=86400'

  secret ENV['DRAGONFLY_SECRET']

  plugin :imagemagick

  url_format "/media/:job/:sha/:name"

  fetch_file_whitelist [
    /content/
  ]

  processor :watermark, WatermarkProcessor.new
  analyser :orientation, OrientationAnalyser.new

end

