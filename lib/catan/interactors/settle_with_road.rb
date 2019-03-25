# frozen_string_literal: true

class SettleWithRoad
  GameNotInitialized = Class.new(StandardError)
  IllegalOperation = Class.new(StandardError)

  def initialize(settlement_spot, road_extension)
    @settlement_spot = settlement_spot
    @road_extension = road_extension
  end

  def invoke(state)
    raise GameNotInitialized unless state.setup?

    raise IllegalOperation, "Spot \##{@settlement_spot} is already taken" if state.settled?(@settlement_spot)

    state.settle(Settlement.new(spot_index: @settlement_spot))
    state.build_road(Road.new(from: @settlement_spot, to: @road_extension))
    state
  end
end
