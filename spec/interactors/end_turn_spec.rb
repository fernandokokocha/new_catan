# frozen_string_literal: true

describe EndTurn do
  let(:game) { Game.new }
  let(:interactor) { EndTurn.new }

  subject(:call) { game.handle(interactor) }

  context 'when game set up and action taken' do
    before(:each) do
      game.handle(@setup_game_interactor)
      game.handle(@settle_with_road_interactor)
    end

    it_behaves_like 'mutating interaction'

    it 'returns success' do
      expect(call.success?).to be(true)
    end

    it 'increments turn' do
      call
      expect(game.turn).to be(2)
    end

    it 'changes current player' do
      call
      next_player = Player.new(
        name: @player_params_fixtures_two_players[1][:name],
        color: @player_params_fixtures_two_players[1][:color]
      )
      expect(game.current_player).to eq(next_player)
    end

    it 'allows next actions' do
      call
      expect(game.action_taken?).to be(false)
    end
  end

  context 'when game not set up' do
    it_behaves_like 'not mutating interaction'

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq('Game not initialized')
    end
  end

  context 'when game set up but no action taken' do
    before(:each) { game.handle(@setup_game_interactor) }

    it_behaves_like 'not mutating interaction'

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq('Action has not been taken')
    end
  end

  context 'players rotation' do
    shared_examples 'correctly sets next player for turn' do |turn, next_player_index|
      it 'changes current player' do
        turn.times do
          game.state.action_taken = true
          game.handle(EndTurn.new)
        end
        next_player_params = players_fixtures[next_player_index]
        expect(game.current_player.name).to eq(next_player_params[:name])
      end
    end

    context 'when two players' do
      before(:each) { game.handle(@setup_game_two_players_interactor) }

      let(:players_fixtures) { @player_params_fixtures_two_players }

      it_behaves_like 'correctly sets next player for turn', 1, 1
      it_behaves_like 'correctly sets next player for turn', 2, 1
      it_behaves_like 'correctly sets next player for turn', 3, 0
      it_behaves_like 'correctly sets next player for turn', 4, 0
      it_behaves_like 'correctly sets next player for turn', 5, 1
      it_behaves_like 'correctly sets next player for turn', 6, 0
      it_behaves_like 'correctly sets next player for turn', 7, 1
    end

    context 'when three players' do
      before(:each) { game.handle(@setup_game_three_players_interactor) }

      let(:players_fixtures) { @player_params_fixtures_three_players }

      it_behaves_like 'correctly sets next player for turn', 1, 1
      it_behaves_like 'correctly sets next player for turn', 2, 2
      it_behaves_like 'correctly sets next player for turn', 3, 2
      it_behaves_like 'correctly sets next player for turn', 4, 1
      it_behaves_like 'correctly sets next player for turn', 5, 0
      it_behaves_like 'correctly sets next player for turn', 6, 0
      it_behaves_like 'correctly sets next player for turn', 7, 1
      it_behaves_like 'correctly sets next player for turn', 8, 2
      it_behaves_like 'correctly sets next player for turn', 9, 0
      it_behaves_like 'correctly sets next player for turn', 10, 1
      it_behaves_like 'correctly sets next player for turn', 11, 2
    end

    context 'when four players' do
      before(:each) { game.handle(@setup_game_four_players_interactor) }

      let(:players_fixtures) { @player_params_fixtures_four_players }

      it_behaves_like 'correctly sets next player for turn', 1, 1
      it_behaves_like 'correctly sets next player for turn', 2, 2
      it_behaves_like 'correctly sets next player for turn', 3, 3
      it_behaves_like 'correctly sets next player for turn', 4, 3
      it_behaves_like 'correctly sets next player for turn', 5, 2
      it_behaves_like 'correctly sets next player for turn', 6, 1
      it_behaves_like 'correctly sets next player for turn', 7, 0
      it_behaves_like 'correctly sets next player for turn', 8, 0
      it_behaves_like 'correctly sets next player for turn', 9, 1
      it_behaves_like 'correctly sets next player for turn', 10, 2
      it_behaves_like 'correctly sets next player for turn', 11, 3
      it_behaves_like 'correctly sets next player for turn', 12, 0
      it_behaves_like 'correctly sets next player for turn', 13, 1
      it_behaves_like 'correctly sets next player for turn', 14, 2
      it_behaves_like 'correctly sets next player for turn', 15, 3
    end
  end
end
