# frozen_string_literal: true

class SettleWithRoad < Interactor
  def initialize(settlement_spot:, road_extension_spot:)
    @settlement_spot = settlement_spot
    @road_extension_spot = road_extension_spot
  end

  def validate(state)
    raise_uninitialized unless state.setup?
    raise_invalid_turn(state.turn) unless valid_turns(state).cover?(state.turn)
    raise_action_already_taken if state.action_taken?

    raise_spot_already_settled(@settlement_spot) if state.settled?(@settlement_spot)

    MapGeometry.bordering_spot_indexes_for(@settlement_spot).each do |spot_index|
      raise_bordering_spot_already_settled(@settlement_spot, spot_index) if state.settled?(spot_index)
    end
  end

  def valid_turns(state)
    max_turn = state.players.count * 2
    (1..max_turn)
  end

  def mutate(state)
    current_player = state.current_player
    state.settlements << Settlement.new(spot_index: @settlement_spot, owner: current_player)
    mutate_gain_resources(state)
    state.roads << Road.new(from: @settlement_spot, to: @road_extension_spot, owner: current_player)
    state.action_taken = true
  end

  def mutate_gain_resources(state)
    MapGeometry
      .bordering_tile_indexes_for_spot(@settlement_spot)
      .map { |tile_index| ArrayUtils.find_by_attribute(state.tiles, :index, tile_index) }
      .each { |tile| state.current_player.resources.add_one(tile.resource) }
  end

  private

  def raise_uninitialized
    raise IllegalOperation, 'Game not initialized'
  end

  def raise_invalid_turn(turn)
    raise IllegalOperation, "Invalid turn for this operation: #{turn}"
  end

  def raise_action_already_taken
    raise IllegalOperation, 'Action already taken'
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
