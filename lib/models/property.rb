class Spotippos::Property < ActiveRecord::Base
    include ActiveModel::Validations

    validates :title, :description, presence: true
    validates :x, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1400 }
    validates :y, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1000 }
    validates :price, numericality: { only_integer: true, greater_than: 0 }
    validates :beds, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
    validates :baths, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 4 }
    validates :square_meters, numericality: { only_integer: true, greater_than_or_equal_to: 20, less_than_or_equal_to: 240 }

    before_save :set_provinces

    def exists!
        property = Spotippos::Property.where(x: self.x, y: self.y)
        raise Spotippos::PropertyAlreadyExist if property.size > 0
        false
    end

    def set_provinces
        self.provinces = Spotippos::ProvinceHelper.find_provinces(self.x, self.y)
    end

    def as_json(options=nil)
      {
        id: id,
        title: title,
        price: price,
        description: description,
        x: x,
        y: y,
        beds: beds,
        baths: baths,
        provinces: provinces.split(','),
        squareMeters: square_meters
      }
    end
end

class Spotippos::PropertyAlreadyExist < ::StandardError; end
