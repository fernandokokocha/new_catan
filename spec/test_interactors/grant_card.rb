# frozen_string_literal: true

class GrantCard < Interactor
  def initialize(player:)
    @player = player
  end

  def mutate
    state
      .cards
      .find(&:no_owner?)
      .give(@player)
  end
end
