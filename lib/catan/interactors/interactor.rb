# frozen_string_literal: true

class Interactor
  IllegalOperation = Class.new(StandardError)

  def invoke(state)
    validate(state)
    mutate(state)
    state
  end

  def validate(_state); end

  def mutate(_state); end
end
