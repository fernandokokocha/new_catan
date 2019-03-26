# frozen_string_literal: true

class SetupGame < Interactor
  def initialize(players:)
    @players = players
  end

  def validate(state)
    raise_already_initialized if state.setup?
  end

  def mutate(state)
    state.setup = true
    state.players = @players.map { |player| Player.new(name: player.fetch(:name), color: player.fetch(:color)) }
  end

  def raise_already_initialized
    raise IllegalOperation, 'Game already initialized'
  end
end
