# frozen_string_literal: true

module CurrentPlayerCalculator
  def self.calc_index(turn, players_count)
    return (players_count * 2 - turn) if reversed_turn?(turn, players_count)

    (turn - 1) % players_count
  end

  # Only the second round of turns is counter-clockwise
  def self.reversed_turn?(turn, players_count)
    min_index = players_count + 1
    max_index = players_count * 2
    (min_index..max_index).cover?(turn)
  end
end
