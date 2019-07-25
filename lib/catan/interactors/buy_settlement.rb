# frozen_string_literal: true

class BuySettlement < Interactor
  COST = Cost.new(wool: 1, grain: 1, lumber: 1, brick: 1)

  def initialize(spot_index:)
    @spot_index = spot_index
  end

  def validate
    raise_uninitialized unless state.setup?
    raise_invalid_turn(state.turn) unless turn_valid?
    raise_action_not_taken unless state.action_taken?

    raise_not_enough_resources unless current_player.can_afford?(COST)

    validate_spots_occupancy

    raise_no_road(@spot_index) unless player_has_road_to?
  end

  def mutate
    current_player.pay(COST)
    state.settlements << Settlement.new(spot_index: @spot_index, owner: current_player)
  end

  def turn_valid?
    TurnTypeCalculator.new(state.players.count).regular_turn?(state.turn)
  end

  def validate_spots_occupancy
    raise_spot_already_settled(@spot_index) if state.settled?(@spot_index)
    MapGeometry.bordering_spot_indexes_for(@spot_index).each do |spot_index|
      raise_bordering_spot_already_settled(@spot_index, spot_index) if state.settled?(spot_index)
    end
  end

  def player_has_road_to?
    state
      .roads
      .select { |road| road.owner.name.equal?(current_player.name) }
      .any? { |road| road.from.equal?(@spot_index) || road.to.equal?(@spot_index) }
  end

  def current_player
    state.current_player
  end

  private

  def raise_uninitialized
    raise IllegalOperation, 'Game not initialized'
  end

  def raise_invalid_turn(turn)
    raise IllegalOperation, "Invalid turn for this operation: #{turn}"
  end

  def raise_action_not_taken
    raise IllegalOperation, 'Action has not been taken'
  end

  def raise_not_enough_resources
    raise IllegalOperation, 'Player has not enough resources'
  end

  def raise_spot_already_settled(spot_index)
    message = "Spot \##{spot_index}: is already settled"
    raise IllegalOperation, message
  end

  def raise_bordering_spot_already_settled(spot_index, bordering_spot_index)
    message = "Spot \##{spot_index}: bordering spot \##{bordering_spot_index} is already settled"
    raise IllegalOperation, message
  end

  def raise_no_road(spot_index)
    message = "No player's road leads to spot \##{spot_index}"
    raise IllegalOperation, message
  end
end
