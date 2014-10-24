
require 'dotenv'
Dotenv.load

require './app.rb'

# Set up Dragonfly as middleware application
require './dragonfly/initializer.rb'

run Sinatra::Application
