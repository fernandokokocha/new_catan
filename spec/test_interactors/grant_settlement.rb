# frozen_string_literal: true

class GrantSettlement < Interactor
  def initialize(player:, spot:)
    @player = player
    @spot = spot
  end

  def mutate
    state.settlements << Settlement.new(spot_index: @spot, owner: @player)
  end
end
