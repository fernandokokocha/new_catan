# frozen_string_literal: true

require 'forwardable'

class Game
  extend Forwardable
  attr_reader :state
  def_delegators :state, :players, :settlements, :cities, :roads, :tiles, :turn, :cards
  def_delegators :queryable_state, :setup?, :current_player, :find_player_by_name, :action_taken?, :score

  def initialize
    @state = State.new
  end

  def queryable_state
    QueryableState.new(@state)
  end

  def handle(interactor)
    @state = interactor.invoke(@state.clone)
    InteractionSuccess.new
  rescue Interactor::IllegalOperation => exeception
    InteractionFailure.new(message: exeception.message)
  end

  def ==(other)
    (other.class == self.class) && (other.state == @state)
  end
end
