# frozen_string_literal: true

require_relative File.join('..', 'lib', 'catan.rb')
require_relative File.join('.', 'shared', 'interactions.rb')
require_relative File.join('.', 'test_interactors', 'set_turn.rb')
require_relative File.join('.', 'test_interactors', 'take_action.rb')
require_relative File.join('.', 'test_interactors', 'set_resources.rb')
require_relative File.join('.', 'test_interactors', 'grant_card.rb')
require_relative File.join('.', 'test_interactors', 'grant_road.rb')
require_relative File.join('.', 'test_interactors', 'grant_settlement.rb')
require_relative File.join('.', 'test_interactors', 'grant_city.rb')

RSpec.configure do |config|
  config.before(:example) do
    @player_params_fixtures = [
      { name: 'Bartek', color: :orange },
      { name: 'Leo', color: :blue },
      { name: 'Carles', color: :white },
      { name: 'Gerard', color: :red }
    ]

    @player_params_fixtures_two_players = @player_params_fixtures.take(2)
    @player_params_fixtures_three_players = @player_params_fixtures.take(3)
    @player_params_fixtures_four_players = @player_params_fixtures

    @setup_game_interactor = SetupGame.new(players_params: @player_params_fixtures_two_players)
    @setup_game_two_players_interactor = @setup_game_interactor
    @setup_game_three_players_interactor = SetupGame.new(players_params: @player_params_fixtures_three_players)
    @setup_game_four_players_interactor = SetupGame.new(players_params: @player_params_fixtures_four_players)

    @settle_with_road_interactor = SettleWithRoad.new(settlement_spot: 1, road_extension_spot: 2)
  end
end
