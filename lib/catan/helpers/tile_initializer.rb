# frozen_string_literal: true

module TileInitializer
  RESOURCES_SET = [Resources::BRICK] * 3 +
                  [Resources::LUMBER] * 4 +
                  [Resources::WOOL] * 4 +
                  [Resources::GRAIN] * 4 +
                  [Resources::ORE] * 3

  CHITS = [2] +
          [3] * 2 +
          [4] * 2 +
          [5] * 2 +
          [6] * 2 +
          [8] * 2 +
          [9] * 2 +
          [10] * 2 +
          [11] * 2 +
          [12]

  def self.basic_tiles
    regular_tiles + [Tile.build_desert]
  end

  def self.regular_tiles
    RESOURCES_SET.zip(CHITS).map.with_index do |(resource, chit), zero_based_index|
      Tile.new(index: zero_based_index + 2, resource: resource, chit: chit)
    end
  end
end
