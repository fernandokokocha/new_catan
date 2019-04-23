# frozen_string_literal: true

class State
  attr_accessor :setup, :players, :settlements, :roads, :tiles, :turn, :action_taken

  def initialize
    @setup = false
    @players = []
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
      settlements: @settlements,
      roads: @roads,
      tiles: @tiles,
      action_taken: @action_taken,
      turn: @turn
    }
  end

  def current_player
    return nil if @players.empty?

    current_player_index = CurrentPlayerCalculator.calc_index(@turn, @players.count)
    @players.detect { |player| player.index == current_player_index }
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

  def ==(other)
    (other.class == self.class) && (other.values == values)
  end
end
