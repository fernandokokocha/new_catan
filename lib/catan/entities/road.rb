# frozen_string_literal: true

class Road
  attr_reader :from, :to, :owner

  def initialize(from:, to:, owner:)
    @from = from
    @to = to
    @owner = owner
    raise ArgumentError, 'Invalid road params' unless valid?
  end

  def valid?
    valid_indexes = MapGeometry.possible_spot_indexes
    valid_indexes.include?(@from) && valid_indexes.include?(@to)
  end

  def ==(other)
    (other.class == self.class) && (other.owner == @owner) && same_or_symmetric_to(other)
  end

  def same_or_symmetric_to(other)
    [from, to].sort == [other.from, other.to].sort
  end
end
