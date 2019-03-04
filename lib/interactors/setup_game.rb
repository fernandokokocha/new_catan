# frozen_string_literal: true

class SetupGame
  GameAlreadyInitialized = Class.new(StandardError)

  def self.invoke(state)
    new(state).invoke
  end

  def initialize(state)
    @state = state
  end

  def invoke
    raise GameAlreadyInitialized if @state.setup?

    @state.setup
    true
  end
end
