# frozen_string_literal: true

class SettleWithRoad
  GameNotInitialized = Class.new(StandardError)
  IllegalOperation = Class.new(StandardError)

  def initialize(settlement_spot, road_extension)
    @settlement_spot = settlement_spot
    @road_extension = road_extension
  end

  def invoke(state)
    validate(state)

    state.settle(Settlement.new(spot_index: @settlement_spot))
    state.build_road(Road.new(from: @settlement_spot, to: @road_extension))
    state
  end

  def validate(state)
    raise_uninitialized unless state.setup?

    raise_spot_already_settled(@settlement_spot) if state.settled?(@settlement_spot)

    MapGeometry.bordering_spot_indexes_for(@settlement_spot).each do |spot_index|
      raise_bordering_spot_already_settled(@settlement_spot, spot_index) if state.settled?(spot_index)
    end
  end

  def raise_uninitialized
    raise GameNotInitialized
  end

  def raise_spot_already_settled(spot_index)
    message = "Spot \##{spot_index}: is already settled"
    raise IllegalOperation, message
  end

  def raise_bordering_spot_already_settled(spot_index, bordering_spot_index)
    message = "Spot \##{spot_index}: bordering spot \##{bordering_spot_index} is already settled"
    raise IllegalOperation, message
  end
end
