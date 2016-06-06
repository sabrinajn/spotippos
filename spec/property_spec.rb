require 'spec_helper'

describe Spotippos::Property, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }

    it { is_expected.to validate_numericality_of(:price).only_integer.is_greater_than(0) }
  end
end
