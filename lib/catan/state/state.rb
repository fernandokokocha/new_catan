# frozen_string_literal: true

class State
  attr_accessor :setup, :players, :settlements, :cities, :roads, :tiles, :turn, :action_taken, :cards

  def initialize
    @setup = false
    @players = []
    @settlements = []
    @cities = []
    @roads = []
    @tiles = TileInitializer.basic_tiles
    @turn = 1
    @action_taken = false
    @cards = CardsInitializer.create_set
  end

  def values
    {
      setup: @setup,
      players: @players,
      settlements: @settlements,
      roads: @roads,
      tiles: @tiles,
      action_taken: @action_taken,
      turn: @turn,
      cards: @cards
    }
  end

  def ==(other)
    (other.class == self.class) && (other.values == values)
  end
end
