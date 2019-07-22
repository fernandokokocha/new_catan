# frozen_string_literal: true

class Player
  EmptyName = Class.new(ArgumentError)
  InvalidColor = Class.new(ArgumentError)

  attr_reader :index, :name, :color, :resources, :cards

  def initialize(index:, name:, color:, resources: Resources.create_empty_bank)
    @index = index
    @name = name
    @color = color.to_sym
    @resources = resources
    @cards = []
    raise EmptyName unless name_valid?
    raise InvalidColor unless color_valid?
  end

  def name_valid?
    !@name.empty?
  end

  def color_valid?
    %i[orange red white blue].include?(@color)
  end

  def pay(cost)
    @resources.substitute(:brick, cost.brick)
    @resources.substitute(:lumber, cost.lumber)
    @resources.substitute(:wool, cost.wool)
    @resources.substitute(:grain, cost.grain)
    @resources.substitute(:ore, cost.ore)
  end

  def ==(other)
    (other.class == self.class) &&
      (other.index == @index) &&
      (other.name == @name) &&
      (other.color == @color) &&
      (other.resources == @resources)
  end
end
