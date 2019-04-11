# frozen_string_literal: true

require 'forwardable'

class Game
  extend Forwardable
  attr_reader :state
  def_delegators :state, :setup?, :players, :current_player, :settlements, :roads, :tiles

  def initialize
    @state = State.new
  end

  def handle(interactor)
    @state = interactor.invoke(@state.clone)
    InteractionSuccess.new
  rescue Interactor::IllegalOperation => exeception
    InteractionFailure.new(message: exeception.message)
  end

  def find_player_by_name(player_name)
    state.players.detect { |player| player.name == player_name }
  end
end
