# frozen_string_literal: true

class BuyCity < Interactor
  COST = Cost.new(grain: 2, ore: 3)

  def initialize(spot_index:)
    @spot_index = spot_index
  end

  def validate
    raise_uninitialized unless state.setup?
    raise_invalid_turn(state.turn) unless turn_valid?
    raise_action_not_taken unless state.action_taken?

    raise_not_enough_resources unless current_player.can_afford?(COST)

    validate_settlement_existance
  end

  def validate_settlement_existance
    raise_no_settlement_on_spot unless player_has_settlement?
  end

  def mutate
    current_player.pay(COST)
    state.settlements.delete(Settlement.new(spot_index: @spot_index, owner: current_player))
    state.cities << City.new(spot_index: @spot_index, owner: current_player)
  end

  def turn_valid?
    TurnTypeCalculator.new(state.players.count).regular_turn?(state.turn)
  end

  def player_has_settlement?
    state.settlements.detect do |settlement|
      settlement.owner.name == current_player.name && settlement.spot_index == @spot_index
    end
  end

  def current_player
    state.current_player
  end

  private

  def raise_action_not_taken
    raise IllegalOperation, 'Action has not been taken'
  end

  def raise_not_enough_resources
    raise IllegalOperation, 'Player has not enough resources'
  end

  def raise_no_settlement_on_spot
    raise IllegalOperation, 'Player has no settlement on requesting spot'
  end
end
