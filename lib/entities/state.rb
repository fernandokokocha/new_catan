# frozen_string_literal: true

class State
  def initialize
    @setup = false
  end

  def setup?
    @setup
  end

  def setup
    @setup = true
  end
end
