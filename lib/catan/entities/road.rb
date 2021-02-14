# frozen_string_literal: true

class Road
  attr_reader :from, :to, :owner

  def initialize(from:, to:, owner:, map_geometry: MapGeometry)
    @from = from
    @to = to
    @owner = owner
    raise ArgumentError, 'Invalid from or to param' unless params_valid?(map_geometry)
    raise ArgumentError, "Spots don't border" unless params_border?(map_geometry)
  end

  def params_valid?(map_geometry)
    valid_indexes = map_geometry.possible_spot_indexes
    valid_indexes.include?(@from) && valid_indexes.include?(@to)
  end

  def params_border?(map_geometry)
    neighbours = map_geometry.bordering_spot_indexes_for(@from)
    neighbours.include?(@to)
  end

  def ==(other)
    (other.class == self.class) && (other.owner == @owner) && same_or_symmetric_to(other)
  end

  def same_or_symmetric_to(other)
    [from, to].sort == [other.from, other.to].sort
  end

  def adjacent_to?(spot)
    (from == spot) || (to == spot)
  end
end
