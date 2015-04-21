
require 'sinatra/base'
require 'sinatra/assetpack'
require 'sinatra/partial'
require 'json'
require 'active_support/core_ext/integer/inflections'
require 'sass'
require 'uglifier'

require_relative 'configuration'
require_relative 'models/photo'
require_relative 'routes'
