# frozen_string_literal: true

require_relative '../lib/catan.rb'

RSpec.configure do |config|
  config.before(:example) do
    players_params = [
      { name: 'Bartek', color: :orange },
      { name: 'Leo', color: :blue }
    ]
    @setup_game_interactor = SetupGame.new(players_params: players_params)
  end
end
