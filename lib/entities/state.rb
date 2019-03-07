# frozen_string_literal: true

class State
  attr_reader :players

  def initialize
    @setup = false
    @players = []
  end

  def setup?
    @setup
  end

  def setup
    @setup = true
  end
end
