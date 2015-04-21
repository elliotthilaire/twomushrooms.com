
source 'http://rubygems.org'

gem 'sinatra'
gem 'sinatra-partial', require: 'sinatra/partial'
gem 'sinatra-assetpack'

gem 'sass', :require => 'sass'
gem 'exifr'          # read date taken from exif image exif data
gem 'dragonfly'      # on the fly image processing for watermarks and thumbnails

gem 'dotenv'
gem 'uglifier'
gem 'rack-cache'
gem 'newrelic_rpm'

group :development do
  gem 'guard-shotgun'
  gem 'guard-livereload', require: false
  gem 'thin'
  gem 'shotgun'
  gem 'rb-fsevent' # effecient file system polling for mac, used by new relic

end

# previously used gems
# gem 'sinatra-thumbnails'		  # replaced by dragonfly
# gem 'sinatra-asset-pipeline'	  # replaced by sinatra-assetpack
# gem 'chronic'                   # natual language formatting of dates
# gem 'json'
# gem 'activesupport'
# gem 'guard'
# gem 'rb-readline'

ruby '2.1.2'
