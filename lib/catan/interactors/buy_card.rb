# frozen_string_literal: true

class BuyCard < Interactor
  def validate
    raise_uninitialized unless state.setup?
    raise_invalid_turn(state.turn) unless turn_valid?
    raise_action_not_taken unless state.action_taken?
  end

  def mutate
    current_player.pay(Cost.new(wool: 1, grain: 1, ore: 1))
    current_player.cards << Card.new
  end

  def turn_valid?
    TurnTypeCalculator.new(state.players.count).regular_turn?(state.turn)
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
end
