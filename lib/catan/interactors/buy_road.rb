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
    state.roads << new_road_candidate
  end

  def new_road_candidate
    @new_road_candidate ||= Road.new(from: @from_index, to: @to_index, owner: current_player)
  rescue ArgumentError
    raise_spots_dont_border
  end

  def current_player
    state.current_player
  end

  def turn_valid?
    TurnTypeCalculator.new(state.players.count).regular_turn?(state.turn)
  end

  def player_has_road_to?
    players_roads.any? do |road|
      road.adjacent_to?(@from_index) || road.adjacent_to?(@to_index)
    end
  end

  def road_already_exists?
    state
      .roads
      .any? { |road| road.same_or_symmetric_to(new_road_candidate) }
  end

  def players_roads
    state
      .roads
      .select { |road| road.owner.name.equal?(current_player.name) }
  end

  private

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

  def raise_spots_dont_border
    raise IllegalOperation, "Spots don't border"
  end
end
