# frozen_string_literal: true

class Settlement
  attr_reader :spot_index

  def initialize(spot_index:)
    @spot_index = spot_index
  end

  def ==(other)
    (other.class == self.class) && (other.spot_index == @spot_index)
  end
end
