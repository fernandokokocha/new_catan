# frozen_string_literal: true

class Resources
  BRICK = :brick
  LUMBER = :lumber
  WOOL = :wool
  GRAIN = :grain
  ORE = :ore

  attr_accessor :brick, :lumber, :wool, :grain, :ore

  def initialize(brick:, lumber:, wool:, grain:, ore:)
    @brick = brick
    @lumber = lumber
    @wool = wool
    @grain = grain
    @ore = ore
  end

  def self.create_empty_bank
    new(
      brick: 0,
      lumber: 0,
      wool: 0,
      grain: 0,
      ore: 0
    )
  end

  def add_one(resource)
    old_value = send(resource)
    send("#{resource}=", old_value + 1)
  end

  def substitute(resource, subtrahend)
    old_value = send(resource)
    send("#{resource}=", old_value - subtrahend)
  end

  def ==(other)
    (other.class == self.class) &&
      (other.brick == @brick) &&
      (other.lumber == @lumber) &&
      (other.wool == @wool) &&
      (other.grain == @grain) &&
      (other.ore == @ore)
  end
end
