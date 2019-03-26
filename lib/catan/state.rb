# frozen_string_literal: true

class State
  attr_accessor :setup, :players, :settlements, :roads

  def initialize
    @setup = false
    @players = []
    @settlements = []
    @roads = []
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
    @settlements.include?(Settlement.new(spot_index: spot_index))
  end
end
