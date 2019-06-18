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
    min_turn = state.players.count * 2 + 1
    state.turn >= min_turn
  end

  def valid_chits
    (2..12)
  end

  def mutate
    state
      .settlements
      .select { |settlement| spot_indexes.include?(settlement.spot_index) }
      .each { |settlement| settlement.owner.resources.add_one(tile.resource) }
    state.action_taken = true
  end

  def tile
    state
      .tiles
      .select { |tile| tile.chit == @chit }
      .first
  end

  def spot_indexes
    MapGeometry.bordering_spot_indexes_for_tile(tile.index)
  end

  private

  def raise_uninitialized
    raise IllegalOperation, 'Game not initialized'
  end

  def raise_invalid_turn(turn)
    raise IllegalOperation, "Invalid turn for this operation: #{turn}"
  end

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
