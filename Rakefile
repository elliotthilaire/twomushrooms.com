
# https://github.com/kalasjocke/sinatra-asset-pipeline
#require 'sinatra/asset_pipeline/task'
#Sinatra::AssetPipeline::Task.define! App


require './app'

# testing
require 'rake/testtask'

task default: :test

Rake::TestTask.new do |t|
  t.pattern = 'test/*_test.rb'
end
