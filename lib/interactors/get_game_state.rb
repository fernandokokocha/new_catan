# frozen_string_literal: true

class GetGameState
  UnitializedGame = Class.new(StandardError)

  def invoke
    raise UnitializedGame
  end
end
