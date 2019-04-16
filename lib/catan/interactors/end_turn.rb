# frozen_string_literal: true

class EndTurn < Interactor
  def validate
    raise_uninitialized unless state.setup?
    raise_action_not_taken unless state.action_taken?
  end

  def mutate
    current_player_index = CurrentPlayerCalculator.calc_index(state.turn, state.players.count)
    state.current_player = state.players.fetch(current_player_index)
    state.turn += 1
    state.action_taken = false
  end

  def calc_next_player_index
    players_count = state.players.count
    current_turn = state.turn
    return (players_count - current_turn - 1) if reversed_turn?

    current_turn % players_count
  end

  def reversed_turn?
    players_count = state.players.count
    min_index = players_count
    max_index = players_count * 2
    (min_index...max_index).cover?(state.turn)
  end

  private

  def raise_uninitialized
    raise IllegalOperation, 'Game not initialized'
  end

  def raise_action_not_taken
    raise IllegalOperation, 'Action has not been taken'
  end
end
