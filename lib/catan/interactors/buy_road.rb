# frozen_string_literal: true

class BuyRoad < Interactor
  COST = Cost.new(lumber: 1, brick: 1)

  def initialize(from_index:, to_index:)
    @from_index = from_index
    @to_index = to_index
  end

  def validate
    raise_uninitialized unless state.setup?
    raise_invalid_turn(state.turn) unless turn_valid?
    raise_action_not_taken unless state.action_taken?

    raise_not_enough_resources unless current_player.can_afford?(COST)

    validate_map_situation
  end

  def validate_map_situation
    raise_no_road_connetion unless player_has_road_to?
    raise_road_already_exists if road_already_exists?
  end

  def mutate
    current_player.pay(COST)
    state.roads << Road.new(from: @from_index, to: @to_index, owner: current_player)
  end

  def current_player
    state.current_player
  end

  def turn_valid?
    TurnTypeCalculator.new(state.players.count).regular_turn?(state.turn)
  end

  def player_has_road_to?
    players_roads.any? do |road|
      from = road.from
      to = road.to
      from.equal?(@from_index) ||
        from.equal?(@to_index) ||
        to.equal?(@from_index) ||
        to.equal?(@to_index)
    end
  end

  def road_already_exists?
    state
      .roads
      .any? { |road| road.from.equal?(@from_index) && road.to.equal?(@to_index) }
  end

  def players_roads
    state
      .roads
      .select { |road| road.owner.name.equal?(current_player.name) }
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

  def raise_no_road_connetion
    raise IllegalOperation, 'Player has no road connetion to new road'
  end

  def raise_road_already_exists
    raise IllegalOperation, "Can't overbuild existing road"
  end
end
