# frozen_string_literal: true

class TileInitializer
  RESOURCES_SET = [Resources::BRICK] * 3 +
                  [Resources::LUMBER] * 4 +
                  [Resources::WOOL] * 4 +
                  [Resources::GRAIN] * 4 +
                  [Resources::ORE] * 3

  def self.basic_tiles
    RESOURCES_SET.map.with_index do |resource, zero_based_index|
      Tile.new(resource: resource, index: zero_based_index + 1)
    end
  end
end
