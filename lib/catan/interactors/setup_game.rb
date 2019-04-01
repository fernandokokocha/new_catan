# frozen_string_literal: true

class SetupGame < Interactor
  MIN_PLAYERS_COUNT = 2

  def initialize(players:)
    @players = players
  end

  def validate(state)
    raise_already_initialized if state.setup?
    raise_too_few_players if @players.count < MIN_PLAYERS_COUNT
  end

  def mutate(state)
    state.setup = true
    state.players = @players.map { |player| Player.new(name: player.fetch(:name), color: player.fetch(:color)) }
  end

  def raise_already_initialized
    raise IllegalOperation, 'Game already initialized'
  end

  def raise_too_few_players
    message = "Too few players: #{@players.count} instead of required at least #{MIN_PLAYERS_COUNT}"
    raise IllegalOperation, message
  end
end
