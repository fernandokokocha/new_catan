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

  def ==(other)
    (other.class == self.class) && (other.values == values)
  end
end
