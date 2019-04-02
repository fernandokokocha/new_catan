# frozen_string_literal: true

class Settlement
  attr_reader :spot_index, :owner

  def initialize(spot_index:, owner:)
    @spot_index = spot_index
    @owner = owner
    raise ArgumentError, 'Invalid settlement params' unless valid?
  end

  def valid?
    MapGeometry.possible_spot_indexes.include?(@spot_index)
  end

  def ==(other)
    (other.class == self.class) && (other.spot_index == @spot_index) && (other.owner == @owner)
  end
end
