class Spotippos::Property
    include ActiveModel::Validations

    attr_accessor :id, :x, :y, :title, :price, :description, :beds, :baths, :square_meters, :provinces

    validates :title, :description, presence: true
    validates :x, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1400 }
    validates :y, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1000 }
    validates :price, numericality: { only_integer: true, greater_than: 0 }
    validates :beds, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
    validates :baths, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 4 }
    validates :square_meters, numericality: { only_integer: true, greater_than_or_equal_to: 20, less_than_or_equal_to: 240 }

    def initialize(attributes = {})
      attributes.each do |attribute, value|
        self.send("#{attribute.underscore}=", value)
      end
      @provinces = []
    end

    def exists!
        property = $properties.select { |p| p.x == self.x && p.y == self.y }
        raise Spotippos::PropertyAlreadyExist if property.size > 0
        false
    end

    def to_json(options=nil)
      {
        id: @id,
        title: @title,
        price: @price,
        description: @description,
        x: @x,
        y: @y,
        beds: @beds,
        baths: @baths,
        provinces: @provinces,
        squareMeters: @square_meters
      }.to_json(options)
    end
end

class Spotippos::PropertyAlreadyExist < ::StandardError; end
