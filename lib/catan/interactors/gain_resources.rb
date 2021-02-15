# frozen_string_literal: true

class GainResources < Interactor
  def initialize(chit:)
    @chit = chit
    @desert_chit = Tile.build_desert.chit
  end

  def validate
    raise_uninitialized unless state.setup?
    raise_invalid_turn(state.turn) unless turn_valid?
    raise_action_already_taken if state.action_taken?

    validate_chit
  end

  def validate_chit
    raise_invalid_chit unless valid_chits.cover?(@chit)
    raise_desert_chit if @chit.equal?(@desert_chit)
  end

  def turn_valid?
    TurnTypeCalculator.new(state.players.count).regular_turn?(state.turn)
  end

  def valid_chits
    (2..12)
  end

  def mutate
    tiles.each { |tile| mutate_gain_resources(tile) }
    state.action_taken = true
  end

  def mutate_gain_resources(tile)
    state
      .settlements
      .select { |settlement| MapGeometry.tile_borders_spot?(tile.index, settlement.spot_index) }
      .each { |settlement| settlement.owner.resources.add_one(tile.resource) }
  end

  def tiles
    state
      .tiles
      .select { |tile| tile.chit.equal?(@chit) }
  end

  private

  def raise_action_already_taken
    raise IllegalOperation, 'Action already taken'
  end

  def raise_invalid_chit
    raise IllegalOperation, "Invalid chit: #{@chit}"
  end

  def raise_desert_chit
    raise IllegalOperation, "Chit indicates desert: #{@desert_chit}"
  end
end
