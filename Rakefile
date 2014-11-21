
# https://github.com/kalasjocke/sinatra-asset-pipeline
require 'sinatra/asset_pipeline/task'
require './app'

Sinatra::AssetPipeline::Task.define! App


# testing
require 'rake/testtask'

task default: :test

Rake::TestTask.new do |t|
  t.pattern = 'test/*_test.rb'
end
