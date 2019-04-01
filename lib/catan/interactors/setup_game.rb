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
    state.players = @players.map { |player| build_player(player) }
  end

  def build_player(player_params)
    name = player_params.fetch(:name)
    # raise_empty_name if name.empty?

    color = player_params.fetch(:color)
    Player.new(name: name, color: color)
  rescue Player::EmptyName
    raise_empty_name
  rescue Player::InvalidColor
    raise_invalid_color(name, color)
  end

  def raise_already_initialized
    raise IllegalOperation, 'Game already initialized'
  end

  def raise_too_few_players
    message = "Too few players: #{@players.count} instead of required at least #{MIN_PLAYERS_COUNT}"
    raise IllegalOperation, message
  end

  def raise_empty_name
    raise IllegalOperation, 'Players include empty name'
  end

  def raise_invalid_color(name, color)
    raise IllegalOperation, "Invalid player color: #{color} of player #{name}"
  end
end
