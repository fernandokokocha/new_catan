# frozen_string_literal: true

class State
  attr_accessor :setup, :players, :current_player, :settlements, :roads, :tiles, :turn, :action_taken

  def initialize
    @setup = false
    @players = []
    @current_player = nil
    @settlements = []
    @roads = []
    @tiles = TileInitializer.basic_tiles
    @turn = 1
    @action_taken = false
  end

  def values
    {
      setup: @setup,
      players: @players,
      current_player: @current_player,
      settlements: @settlements,
      roads: @roads,
      tiles: @tiles,
      action_taken: @action_taken
    }
  end

  def setup?
    @setup
  end

  def settled?(spot_index)
    @settlements.detect { |settlement| settlement.spot_index == spot_index }
  end

  def action_taken?
    @action_taken
  end

  def find_player_by_name(player_name)
    @players.detect { |player| player.name == player_name }
  end
end
