# frozen_string_literal: true

class SettleWithRoad
  GameNotInitialized = Class.new(StandardError)

  # attr_reader :settlement_place

  def initialize(settlement_place, road_extension)
    @settlement_place = settlement_place
    @road_extension = road_extension
  end

  def invoke(state)
    raise GameNotInitialized unless state.setup?

    state.settle(Settlement.new(spot_index: @settlement_place))
    state.build_road(Road.new(from: @settlement_place, to: @road_extension))
    state
  end
end
