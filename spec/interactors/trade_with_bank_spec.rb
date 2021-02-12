# frozen_string_literal: true

describe TradeWithBank do
  let(:game) { Game.new }
  let(:gives) { Resources::WOOL }
  let(:takes) { Resources::ORE }
  let(:interactor) { TradeWithBank.new(gives: gives, takes: takes) }
  let(:player) { game.current_player }

  subject(:call) { game.handle(interactor) }

  context 'with valid data' do
    before(:each) do
      game.handle(@setup_game_interactor)
      game.handle(SetTurn.new(turn: 10))
      game.handle(SetResources.new(player: player, resource_values: { wool: 4, grain: 0, ore: 0, lumber: 0, brick: 0 }))
      game.handle(TakeAction.new)
    end

    it_behaves_like 'mutating interaction'

    it 'returns success' do
      expect(call.success?).to be(true)
    end

    it 'trades resources' do
      call
      expect(game.current_player.resources).to eq(Resources.new(wool: 0, grain: 0, ore: 1, lumber: 0, brick: 0))
    end

    it 'does not untake action' do
      call
      expect(game.action_taken?).to be(true)
    end
  end

  context 'with valid data - with different resource' do
    let(:gives) { Resources::GRAIN }

    before(:each) do
      game.handle(@setup_game_interactor)
      game.handle(SetTurn.new(turn: 10))
      game.handle(SetResources.new(player: player, resource_values: { wool: 0, grain: 4, ore: 0, lumber: 0, brick: 0 }))
      game.handle(TakeAction.new)
    end

    it_behaves_like 'mutating interaction'

    it 'returns success' do
      expect(call.success?).to be(true)
    end

    it 'trades resources' do
      call
      expect(game.current_player.resources).to eq(Resources.new(wool: 0, grain: 0, ore: 1, lumber: 0, brick: 0))
    end

    it 'does not untake action' do
      call
      expect(game.action_taken?).to be(true)
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

  context 'when too early turn' do
    before(:each) do
      game.handle(@setup_game_interactor)
      game.handle(SetTurn.new(turn: 1))
      game.handle(SetResources.new(player: player, resource_values: { wool: 4, grain: 0, ore: 0, lumber: 0, brick: 0 }))
      game.handle(TakeAction.new)
    end

    it_behaves_like 'not mutating interaction'

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq('Invalid turn for this operation: 1')
    end
  end

  context 'when action not taken' do
    before(:each) do
      game.handle(@setup_game_interactor)
      game.handle(SetTurn.new(turn: 10))
      game.handle(SetResources.new(player: player, resource_values: { wool: 4, grain: 0, ore: 0, lumber: 0, brick: 0 }))
    end

    it_behaves_like 'not mutating interaction'

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq('Action has not been taken')
    end
  end

  context 'when player has not enough resources' do
    before(:each) do
      game.handle(@setup_game_interactor)
      game.handle(SetTurn.new(turn: 10))
      game.handle(SetResources.new(player: player, resource_values: { wool: 0, grain: 0, ore: 0, lumber: 0, brick: 0 }))
      game.handle(GrantRoad.new(player: player, from: 1, to: 2))
      game.handle(TakeAction.new)
    end

    it_behaves_like 'not mutating interaction'

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq('Player has not enough wool')
    end
  end
end
