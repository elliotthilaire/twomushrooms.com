
require 'dotenv'
Dotenv.load

require './app.rb'

##
# New Relic Monitoring
# https://docs.newrelic.com/docs/agents/ruby-agent/frameworks/sinatra-support
require 'newrelic_rpm'

require 'rack/cache'

use Rack::Cache,
  :verbose     => false,
  :metastore   => 'file:tmp/cache/rack/meta',
  :entitystore => 'file:tmp/cache/rack/body'

run App
