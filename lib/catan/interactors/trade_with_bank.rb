# frozen_string_literal: true

class TradeWithBank < Interactor
  LEVERAGE = 4

  def initialize(gives:, takes:)
    @gives = gives
    @takes = takes
  end

  def validate
    raise_uninitialized unless state.setup?
    raise_invalid_turn(state.turn) unless turn_valid?
    raise_action_not_taken unless state.action_taken?

    raise_player_cannot_afford unless current_player.can_afford?(cost)
  end

  def turn_valid?
    TurnTypeCalculator.new(state.players.count).regular_turn?(state.turn)
  end

  def mutate
    current_player.pay(cost)
    current_player.resources.add_one(@takes)
  end

  def cost
    values = {
      brick: 0,
      lumber: 0,
      wool: 0,
      ore: 0,
      grain: 0
    }.tap { |val| val[@gives] = LEVERAGE }
    Resources.new(values)
  end

  def current_player
    state.current_player
  end

  private

  def raise_invalid_turn(turn)
    raise IllegalOperation, "Invalid turn for this operation: #{turn}"
  end

  def raise_action_not_taken
    raise IllegalOperation, 'Action has not been taken'
  end

  def raise_player_cannot_afford
    raise IllegalOperation, "Player has not enough #{@gives}"
  end
end
