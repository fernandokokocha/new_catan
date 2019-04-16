# frozen_string_literal: true

class CurrentPlayerCalculator
  def self.calc_index(turn, players_count)
    return (players_count - turn) if reversed_turn?(turn, players_count)

    (turn - 1) % players_count
  end

  def self.reversed_turn?(turn, players_count)
    min_index = players_count + 1
    max_index = players_count * 2
    (min_index..max_index).cover?(turn)
  end
end
