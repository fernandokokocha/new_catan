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
end
