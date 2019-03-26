# frozen_string_literal: true

class SetupGame < Interactor
  GameAlreadyInitialized = Class.new(StandardError)

  def initialize(player_names)
    @player_names = player_names
  end

  def validate(state)
    raise GameAlreadyInitialized if state.setup?
  end

  def mutate(state)
    state.setup
    state.setup_players(@player_names)
  end
end
