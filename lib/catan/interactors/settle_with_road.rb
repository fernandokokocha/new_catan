# frozen_string_literal: true

class SettleWithRoad < Interactor
  def initialize(settlement_spot:, road_extension_spot:)
    @settlement_spot = settlement_spot
    @road_extension_spot = road_extension_spot
  end

  def validate(state)
    raise_uninitialized unless state.setup?

    raise_spot_already_settled(@settlement_spot) if state.settled?(@settlement_spot)

    MapGeometry.bordering_spot_indexes_for(@settlement_spot).each do |spot_index|
      raise_bordering_spot_already_settled(@settlement_spot, spot_index) if state.settled?(spot_index)
    end
  end

  def mutate(state)
    state.settlements << Settlement.new(spot_index: @settlement_spot)
    state.roads << Road.new(from: @settlement_spot, to: @road_extension_spot)
  end

  private

  def raise_uninitialized
    raise IllegalOperation, 'Game not initialized'
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
