# frozen_string_literal: true

class QueryableState < State
  def initialize
    super
  end

  def current_player
    return nil if players.empty?

    current_player_index = CurrentPlayerCalculator.new(players.count).calc_index(turn)
    players.detect { |player| player.index == current_player_index }
  end

  def setup?
    setup
  end

  def settled?(spot_index)
    settlements.detect { |settlement| settlement.spot_index == spot_index }
  end

  def action_taken?
    action_taken
  end

  def find_player_by_name(player_name)
    players.detect { |player| player.name == player_name }
  end

  def score(player)
    settlements.select { |settlement| settlement.owner == player }.count
  end
end
