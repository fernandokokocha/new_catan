# frozen_string_literal: true

require 'forwardable'

class Game
  extend Forwardable
  attr_reader :state
  def_delegators :state, :setup?, :players, :settlements, :roads

  def initialize
    @state = State.new
  end

  def handle(interactor)
    result = interactor.invoke(@state.clone)

    @state = result
    true
  rescue SettleWithRoad::IllegalOperation => _
    InteractionFailure.new(message: '')
  end
end
