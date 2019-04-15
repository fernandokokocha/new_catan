# frozen_string_literal: true

class SetTurn < Interactor
  def initialize(turn:)
    @turn = turn
  end

  def mutate
    state.turn = @turn
  end
end
