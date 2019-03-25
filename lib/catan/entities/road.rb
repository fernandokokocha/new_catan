# frozen_string_literal: true

class Road
  attr_reader :from, :to

  def initialize(from:, to:)
    @from = from
    @to = to
  end

  def ==(other)
    (other.class == self.class) && (other.from == @from) && (other.to && @to)
  end
end
