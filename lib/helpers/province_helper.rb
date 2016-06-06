require 'json'

class Spotippos::ProvinceHelper

  def self.parse(file_path)
    provinces = JSON.parse(File.read(file_path))
    provinces.map do |name, bounds|
      province = Spotippos::Province.new(name, bounds["boundaries"]["upperLeft"], bounds["boundaries"]["bottomRight"])
      province
    end
  end

  def self.find_provinces(x, y)
    provinces_selected = $provinces.select { |p| x >= p.upper_left["x"] && x <= p.bottom_right["x"] && y >= p.bottom_right["y"] && y <= p.upper_left["y"] }
    provinces_selected.map { |p| p.name }.join(',')
  end
end
