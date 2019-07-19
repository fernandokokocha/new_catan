# frozen_string_literal: true

class TurnTypeCalculator
  def initialize(players_count)
    @players_count = players_count
  end

  # Only the second round of turns is counter-clockwise
  def reversed_turn?(turn)
    min_turn = @players_count + 1
    max_turn = @players_count * 2
    (min_turn..max_turn).cover?(turn)
  end

  def regular_turn?(turn)
    min_turn = @players_count * 2 + 1
    turn >= min_turn
  end
end
