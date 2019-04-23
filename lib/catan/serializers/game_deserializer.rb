# frozen_string_literal: true

class GameDeserializer
  def initialize(hash)
    @hash = hash
  end

  def call
    Game.new
  end
end
