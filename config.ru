
require 'dotenv'
Dotenv.load

require './app.rb'

##
# New Relic Monitoring
# https://docs.newrelic.com/docs/agents/ruby-agent/frameworks/sinatra-support
require 'newrelic_rpm'

# Set up Dragonfly as middleware application
require './dragonfly/initializer.rb'

run Sinatra::Application
