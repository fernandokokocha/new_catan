# frozen_string_literal: true

require_relative '../lib/catan.rb'

RSpec.configure do |config|
  config.before(:example) do
    players = [
      { name: 'Bartek', color: :orange },
      { name: 'Leo', color: :blue }
    ]
    @setup_game_interactor = SetupGame.new(players: players)
  end
end
