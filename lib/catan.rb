# frozen_string_literal: true

require 'forwardable'

Dir[File.join(__dir__, 'entities', '*.rb')].each { |file| require file }

Dir[File.join(__dir__, 'interactors', '*.rb')].each { |file| require file }

class Catan
  extend Forwardable
  attr_reader :state
  def_delegators :state, :setup?, :players, :settlements, :roads

  def initialize
    @state = State.new
  end

  def handle(interactor)
    @state = interactor.invoke(@state.clone)
    true
  end
end
