# frozen_string_literal: true

class Card
  attr_reader :owner

  NO_OWNER = :no_owner

  def initialize(owner: NO_OWNER)
    @owner = owner
  end

  def give(player)
    @owner = player
  end

  def no_owner?
    @owner == NO_OWNER
  end

  def owned_by?(player)
    @owner == player
  end

  def victory?
    true
  end

  def ==(other)
    (other.class == self.class) &&
      (other.owner == @owner)
  end
end
