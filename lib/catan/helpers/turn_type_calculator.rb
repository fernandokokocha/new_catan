# frozen_string_literal: true

class TurnTypeCalculator
  def initialize(players_count)
    @players_count = players_count
  end

  # Only the second round of turns is counter-clockwise
  def reversed_turn?(turn)
    min_index = @players_count + 1
    max_index = @players_count * 2
    (min_index..max_index).cover?(turn)
  end
end
