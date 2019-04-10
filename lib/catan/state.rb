# frozen_string_literal: true

class State
  attr_accessor :setup, :players, :current_player, :settlements, :roads, :tiles

  def initialize
    @setup = false
    @players = []
    @current_player = nil
    @settlements = []
    @roads = []
    @tiles = TileInitializer.basic_tiles
  end

  def values
    {
      setup: @setup,
      players: @players,
      settlements: @settlements,
      roads: @roads
    }
  end

  def setup?
    @setup
  end

  def settled?(spot_index)
    @settlements.detect { |settlement| settlement.spot_index == spot_index }
  end
end
