source 'http://rubygems.org'

gem 'sinatra'
gem 'sinatra-partial', require: 'sinatra/partial'
gem 'sinatra-assetpack', require: 'sinatra/assetpack'

gem 'aws-sdk'
gem 'sass', require: 'sass'
gem 'exifr'          # read date_taken from image exif data
gem 'dragonfly'      # on the fly image processing for watermarks and thumbnails

gem 'thin'
gem 'dotenv'
gem 'rack-cache'
gem 'newrelic_rpm'

group :development do
  gem 'guard-shotgun'
  gem 'guard-livereload', require: false
  gem 'shotgun'
  gem 'rb-fsevent' # effecient file system polling for mac, used by newrelic
end

ruby '2.1.2'
