require 'bundler'
Bundler.require

$: << File.dirname(__FILE__)
require File.dirname(__FILE__) + '/config/spotippos.rb'

run Rack::URLMap.new Spotippos.route_map
