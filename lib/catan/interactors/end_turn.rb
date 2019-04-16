# frozen_string_literal: true

class EndTurn < Interactor
  def validate
    raise_uninitialized unless state.setup?
    raise_action_not_taken unless state.action_taken?
  end

  def mutate
    state.turn += 1
    state.action_taken = false
  end

  private

  def raise_uninitialized
    raise IllegalOperation, 'Game not initialized'
  end

  def raise_action_not_taken
    raise IllegalOperation, 'Action has not been taken'
  end
end
