# frozen_string_literal: true

class Cost
  attr_reader :brick, :lumber, :wool, :grain, :ore

  def initialize(brick: 0, lumber: 0, wool: 0, grain: 0, ore: 0)
    @brick = brick
    @lumber = lumber
    @wool = wool
    @grain = grain
    @ore = ore
  end
end
