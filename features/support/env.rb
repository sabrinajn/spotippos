require 'bundler'
Bundler.require :default, :test

ENV['RACK_ENV'] = 'test'
require File.expand_path(File.dirname(__FILE__) + '/../../spotippos.rb')

require 'rspec'
require 'rack/test'

Before do
  Spotippos::Property.delete_all
end

class SpotipposWorld
  include RSpec::Expectations
  include RSpec::Matchers
  include Rack::Test::Methods

  def app
    Rack::URLMap.new Spotippos.route_map
  end
end

World do
  SpotipposWorld.new
end
