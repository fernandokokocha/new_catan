# frozen_string_literal: true

class Player
  attr_reader :name, :color

  def initialize(name:, color:)
    @name = name
    @color = color
    raise ArgumentError unless valid?
  end

  def valid?
    %i[orange red white blue].include?(@color)
  end

  def ==(other)
    (other.class == self.class) && (other.name == @name) && (other.color == @color)
  end
end
