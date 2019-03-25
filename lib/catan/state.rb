# frozen_string_literal: true

class State
  attr_reader :players, :settlements, :roads

  def initialize
    @setup = false
    @players = []
    @settlements = []
    @roads = []
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

  def settle(settlement)
    @settlements << settlement
  end

  def settled?(spot_index)
    @settlements.include?(Settlement.new(spot_index: spot_index))
  end

  def build_road(road)
    @roads << road
  end
end
