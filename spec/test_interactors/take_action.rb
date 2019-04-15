# frozen_string_literal: true

class TakeAction < Interactor
  def mutate
    state.action_taken = true
  end
end
