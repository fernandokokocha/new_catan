# frozen_string_literal: true

class Interactor
  IllegalOperation = Class.new(StandardError)

  attr_reader :state

  def invoke(state)
    @state = QueryableState.new(state)
    validate
    mutate
    state
  end

  def validate; end

  def mutate; end

  def raise_uninitialized
    raise IllegalOperation, 'Game not initialized'
  end

  def raise_invalid_turn(turn)
    raise IllegalOperation, "Invalid turn for this operation: #{turn}"
  end
end
