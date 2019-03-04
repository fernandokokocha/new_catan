# frozen_string_literal: true

class SetupGame
  # WIP - smells of :reek:UtilityFunction
  def invoke
    {
      map: Map.new
    }
  end
end
