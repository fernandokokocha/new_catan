# frozen_string_literal: true

require_relative File.join('..', 'lib', 'catan.rb')
require_relative File.join('.', 'shared', 'interactions.rb')

RSpec.configure do |config|
  config.before(:example) do
    @player_params_fixtures = [
      { name: 'Bartek', color: :orange },
      { name: 'Leo', color: :blue }
    ]
    @setup_game_interactor = SetupGame.new(players_params: @player_params_fixtures)
    @settle_with_road_interactor = SettleWithRoad.new(settlement_spot: 1, road_extension_spot: 2)
  end
end
