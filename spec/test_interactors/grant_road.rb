# frozen_string_literal: true

class GrantRoad < Interactor
  def initialize(player:, from:, to:)
    @player = player
    @from = from
    @to = to
  end

  def mutate
    state.roads << Road.new(owner: @player, from: @from, to: @to)
  end
end
