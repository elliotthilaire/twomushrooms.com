
require 'dotenv'
Dotenv.load

require './app.rb'

##
# New Relic Monitoring
# https://docs.newrelic.com/docs/agents/ruby-agent/frameworks/sinatra-support
require 'newrelic_rpm'

run App
