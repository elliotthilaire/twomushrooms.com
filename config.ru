require './app.rb'

require 'rack/cache'

use Rack::Cache,
    verbose: false,
    metastore: 'file:tmp/cache/rack/meta',
    entitystore: 'file:tmp/cache/rack/body'

run App
