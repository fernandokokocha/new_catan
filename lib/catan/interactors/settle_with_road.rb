# frozen_string_literal: true

class SettleWithRoad < Interactor
  def initialize(settlement_spot:, road_extension_spot:)
    @settlement_spot = settlement_spot
    @road_extension_spot = road_extension_spot
  end

  def validate
    raise_uninitialized unless state.setup?
    raise_invalid_turn(state.turn) unless turn_valid?
    raise_action_already_taken if state.action_taken?

    validate_spots_bordering
    validate_spots_occupancy
  end

  def turn_valid?
    TurnTypeCalculator.new(state.players.count).build_up_turn?(state.turn)
  end

  def validate_spots_bordering
    spot_bordering = MapGeometry.bordering_spot_indexes_for(@settlement_spot).include?(@road_extension_spot)
    raise_spots_not_bordering(@settlement_spot, @road_extension_spot) unless spot_bordering
  end

  def validate_spots_occupancy
    raise_spot_already_settled(@settlement_spot) if state.settled?(@settlement_spot)

    MapGeometry.bordering_spot_indexes_for(@settlement_spot).each do |spot_index|
      raise_bordering_spot_already_settled(@settlement_spot, spot_index) if state.settled?(spot_index)
    end
  end

  def mutate
    mutate_build_settlement
    mutate_gain_resources if TurnTypeCalculator.new(state.players.count).reversed_turn?(state.turn)
    mutate_build_road
    state.action_taken = true
  end

  def mutate_build_settlement
    state.settlements << Settlement.new(spot_index: @settlement_spot, owner: state.current_player)
  end

  def mutate_gain_resources
    MapGeometry
      .bordering_tile_indexes_for_spot(@settlement_spot)
      .map { |tile_index| ArrayUtils.find_by_attribute(state.tiles, :index, tile_index) }
      .reject { |tile| tile == Tile.build_desert }
      .each { |tile| state.current_player.resources.add_one(tile.resource) }
  end

  def mutate_build_road
    state.roads << Road.new(from: @settlement_spot, to: @road_extension_spot, owner: state.current_player)
  end

  private

  def raise_action_already_taken
    raise IllegalOperation, 'Action already taken'
  end

  def raise_spots_not_bordering(spot_1_index, spot_2_index)
    message = "Road cannot be built, spots do not border: \##{spot_1_index}, \##{spot_2_index}"
    raise IllegalOperation, message
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
