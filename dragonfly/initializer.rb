require 'dragonfly'
require_relative 'watermark_processor'
require_relative 'orientation_analyser'

Dragonfly.logger = Logger.new('log/dragonfly.log')

Dragonfly.app.configure do
  response_header 'Cache-Control', 'public, max-age=604800'

  secret ENV['DRAGONFLY_SECRET']

  plugin :imagemagick

  url_format '/media/:job/:sha/:name'

  fetch_file_whitelist [
    /tmp/,
    /content/
  ]

  processor :watermark, WatermarkProcessor.new
  analyser :orientation, OrientationAnalyser.new
end
