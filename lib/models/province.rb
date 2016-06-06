class Spotippos::Province
  include ActiveModel::Validations

  attr_accessor :name, :upper_left, :bottom_right

  validates :name, :upper_left, :bottom_right, presence: true

  def initialize(name, upper_left={}, bottom_right={})
    @name = name
    @upper_left = upper_left
    @bottom_right = bottom_right
  end
end
