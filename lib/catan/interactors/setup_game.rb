# frozen_string_literal: true

class SetupGame
  GameAlreadyInitialized = Class.new(StandardError)

  attr_reader :player_names

  def initialize(player_names)
    @player_names = player_names
  end

  def invoke(state)
    raise GameAlreadyInitialized if state.setup?

    state.setup
    state.setup_players(player_names)
    state
  end
end
