# frozen_string_literal: true

require_relative File.join('..', 'lib', 'catan.rb')
require_relative File.join('.', 'shared', 'interactions.rb')

RSpec.configure do |config|
  config.before(:example) do
    players_params = [
      { name: 'Bartek', color: :orange },
      { name: 'Leo', color: :blue }
    ]
    @setup_game_interactor = SetupGame.new(players_params: players_params)
  end
end
