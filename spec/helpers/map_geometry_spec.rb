# frozen_string_literal: true

describe MapGeometry do
  MapGeometry.possible_spot_indexes.each do |spot_index|
    it "has bordering spots for spot \##{spot_index}" do
      expect(MapGeometry.bordering_spot_indexes_for(spot_index).length).to_not be(0)
    end

    MapGeometry.bordering_spot_indexes_for(spot_index).each do |bordering_spot_index|
      it "spot \##{spot_index} borders spot \##{bordering_spot_index} and vice versa" do
        expect(MapGeometry.bordering_spot_indexes_for(bordering_spot_index)).to include(spot_index)
      end
    end
  end
end
