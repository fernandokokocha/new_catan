# frozen_string_literal: true

class Map
  def state
    nil
  end

  def eql?(other)
    state == other.state
  end
end
