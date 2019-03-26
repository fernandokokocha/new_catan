# frozen_string_literal: true

class Player
  attr_reader :name, :color

  def initialize(name:, color:)
    @name = name
    @color = color
  end

  def ==(other)
    (other.class == self.class) && (other.name == @name) && (other.color == @color)
  end
end
