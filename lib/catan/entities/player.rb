# frozen_string_literal: true

class Player
  EmptyName = Class.new(ArgumentError)
  InvalidColor = Class.new(ArgumentError)

  attr_reader :name, :color, :resources

  def initialize(name:, color:)
    @name = name
    @color = color
    @resources = Resources.create_empty_bank
    raise EmptyName unless name_valid?
    raise InvalidColor unless color_valid?
  end

  def name_valid?
    !@name.empty?
  end

  def color_valid?
    %i[orange red white blue].include?(@color)
  end

  def ==(other)
    (other.class == self.class) &&
      (other.name == @name) &&
      (other.color == @color) &&
      (other.resources == @resources)
  end
end
