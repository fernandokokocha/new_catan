# frozen_string_literal: true

require 'forwardable'

class Game
  extend Forwardable
  attr_reader :state
  def_delegators :state, :setup?, :players, :current_player, :settlements, :roads
  def_delegators :state, :tiles, :find_player_by_name, :turn, :action_taken?

  def initialize
    @state = State.new
  end

  def handle(interactor)
    @state = interactor.invoke(@state.clone)
    InteractionSuccess.new
  rescue Interactor::IllegalOperation => exeception
    InteractionFailure.new(message: exeception.message)
  end
end
