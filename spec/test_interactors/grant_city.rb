# frozen_string_literal: true

class GrantCity < Interactor
  def initialize(player:, spot:)
    @player = player
    @spot = spot
  end

  def mutate
    state.cities << City.new(spot_index: @spot, owner: @player)
  end
end
