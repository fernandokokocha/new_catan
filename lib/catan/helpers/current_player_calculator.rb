# frozen_string_literal: true

class CurrentPlayerCalculator
  def initialize(players_count)
    @players_count = players_count
  end

  def calc_index(turn)
    return (@players_count * 2 - turn) if TurnTypeCalculator.new(@players_count).reversed_turn?(turn)

    (turn - 1) % @players_count
  end
end
