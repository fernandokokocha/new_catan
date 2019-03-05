# frozen_string_literal: true

class SetupGame
  GameAlreadyInitialized = Class.new(StandardError)

  def self.invoke(state)
    new(state).invoke
  end

  def initialize(state)
    @state = state.clone
  end

  def invoke
    raise GameAlreadyInitialized if @state.setup?

    @state.setup
    @state
  end
end
