# frozen_string_literal: true

class TurnTypeCalculator
  def initialize(players_count)
    @players_count = players_count
  end

  # Is a round the first one for its player?
  def initial_turn?(turn)
    max_turn = @players_count
    turn <= max_turn
  end

  # Is a round the second one for its players?
  # Only the second round of turns is counter-clockwise
  def reversed_turn?(turn)
    min_turn = @players_count + 1
    max_turn = @players_count * 2
    (min_turn..max_turn).cover?(turn)
  end

  # Is a round the third one or further one for its players?
  def regular_turn?(turn)
    min_turn = @players_count * 2 + 1
    turn >= min_turn
  end

  def build_up_turn?(turn)
    !regular_turn?(turn)
  end
end
