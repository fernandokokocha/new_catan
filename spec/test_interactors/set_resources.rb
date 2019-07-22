# frozen_string_literal: true

class SetResources < Interactor
  def initialize(player:, resource_values:)
    @player = player
    @resource_values = resource_values
  end

  def mutate
    index = @player.index
    updated_player = Player.new(
      index: index,
      color: @player.color,
      name: @player.name,
      resources: resources
    )
    state.players[index] = updated_player
  end

  private

  def resources
    Resources.create_empty_bank.tap do |resources|
      @resource_values.each do |key, entry|
        entry.times { resources.add_one(key) }
      end
    end
  end
end
