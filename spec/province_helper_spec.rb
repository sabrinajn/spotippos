require 'spec_helper.rb'

describe Spotippos::ProvinceHelper do

  describe '.parse' do
    let(:provinces) { Spotippos::ProvinceHelper.parse('provinces.json') }

    it 'parses all provinces' do
      expect(provinces.length).to eq 6
      expect(provinces.first).to be_instance_of Spotippos::Province
    end

    it 'parses province correct' do
      expect(provinces.first).to be_valid
    end

    it 'parses boundaries' do
      province = provinces.first
      expect(province.upper_left['x']).to eq 0
      expect(province.upper_left['y']).to eq 1000
      expect(province.bottom_right['x']).to eq 600
      expect(province.bottom_right['y']).to eq 500
    end
  end

  describe '.find_provinces' do
    before { $provinces = Spotippos::ProvinceHelper.parse('provinces.json') }

    subject { Spotippos::ProvinceHelper.find_provinces(x, y) }

    context 'when province not found' do
        let(:x) { 7000 }
        let(:y) { 1000 }

        it 'returns empty' do
            expect(subject).to eq ""
        end
    end

    context 'when province found' do
      context 'and its in the province limit' do
        let(:x) { 0 }
        let(:y) { 800 }

        it 'returns only province name' do
          expect(subject).to eq 'Gode'
        end
      end

      context 'and its in the province' do
        let(:x) { 400 }
        let(:y) { 800 }

        it 'returns only provinces name' do
          expect(subject).to eq 'Gode,Ruja'
        end
      end
    end
  end
end
