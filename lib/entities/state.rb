# frozen_string_literal: true

class State
  attr_reader :players

  def initialize
    @setup = false
    @players = []
  end

  def setup?
    @setup
  end

  def setup
    @setup = true
  end

  def setup_players(player_names)
    @players = player_names.map { |name| { name: name } }
  end
end
