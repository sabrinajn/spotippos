ENV['RACK_ENV'] ||= 'development'

require 'sinatra'
require 'active_record'
require 'active_model'
require 'yaml'

config = YAML::load(File.open('config/database.yml'))[ENV['RACK_ENV']]
ActiveRecord::Base.establish_connection(config)

module Spotippos
  Dir['./lib/controllers/*.rb'].each { |controller| require controller }
  Dir['./lib/models/*.rb'].each { |model| require model }
  require './lib/helpers/province_helper.rb'

  class << self
    def route_map
      map = {
        '/properties'   => Spotippos::PropertyController
      }

      map
    end
  end
end

$provinces = Spotippos::ProvinceHelper.parse('config/provinces.json')
