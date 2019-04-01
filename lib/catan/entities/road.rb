# frozen_string_literal: true

class Road
  attr_reader :from, :to

  def initialize(from:, to:)
    @from = from
    @to = to
    raise ArgumentError, 'Invalid road params' unless valid?
  end

  def valid?
    valid_indexes = MapGeometry.possible_spot_indexes
    valid_indexes.include?(@from) && valid_indexes.include?(@to)
  end

  def ==(other)
    (other.class == self.class) && (other.from == @from) && (other.to && @to)
  end
end
