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

  def can_afford?(cost)
    Resources::ALL.each do |resource|
      return false if @resources.send(resource) < cost.send(resource)
    end
    true
  end

  def pay(cost)
    Resources::ALL.each do |resource|
      @resources.substitute(resource, cost.send(resource))
    end
  end

  def ==(other)
    (other.class == self.class) &&
      (other.index == @index) &&
      (other.name == @name) &&
      (other.color == @color) &&
      (other.resources == @resources)
  end
end
