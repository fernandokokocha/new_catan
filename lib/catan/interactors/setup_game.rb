# frozen_string_literal: true

class SetupGame < Interactor
  def initialize(player_names:)
    @player_names = player_names
  end

  def validate(state)
    raise_already_initialized if state.setup?
  end

  def mutate(state)
    state.setup = true
    state.players = @player_names.map { |name| { name: name } }
  end

  def raise_already_initialized
    raise IllegalOperation, 'Game already initialized'
  end
end
