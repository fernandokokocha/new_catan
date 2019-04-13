# frozen_string_literal: true

class Interactor
  IllegalOperation = Class.new(StandardError)

  attr_reader :state

  def invoke(state)
    @state = state
    validate
    mutate
    state
  end

  def validate; end

  def mutate; end
end
