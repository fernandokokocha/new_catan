# frozen_string_literal: true

describe BuyCity do
  let(:game) { Game.new }
  let(:interactor) { BuyCity.new(spot_index: spot_index) }
  let(:spot_index) { 1 }
  let(:other_spot_index) { 3 }
  let(:player) { game.current_player }
  let(:other_player) { game.players[0] }

  subject(:call) { game.handle(interactor) }

  context 'with valid data' do
    before(:each) do
      game.handle(@setup_game_interactor)
      game.handle(SetTurn.new(turn: 10))
      game.handle(SetResources.new(player: player, resource_values: { wool: 0, grain: 2, ore: 3, lumber: 0, brick: 0 }))
      game.handle(GrantSettlement.new(spot: spot_index, player: player))
      game.handle(TakeAction.new)
    end

    it_behaves_like 'mutating interaction'

    it 'returns success' do
      expect(call.success?).to be(true)
    end

    it 'takes resources' do
      call
      expect(game.current_player.resources).to eq(Resources.new(wool: 0, grain: 0, ore: 0, lumber: 0, brick: 0))
    end

    it 'builds one city' do
      old_length = game.cities.length
      call
      expect(game.cities.length).to eq(old_length + 1)
    end

    it 'builds correct city' do
      old_cities = game.cities.clone
      player = game.current_player
      call
      new_city = (game.cities - old_cities).first
      expect(new_city).to eq(City.new(spot_index: spot_index, owner: player))
    end

    it 'removes one settlement' do
      old_length = game.settlements.length
      call
      expect(game.settlements.length).to eq(old_length - 1)
    end

    it 'removes correct settlement' do
      old_settlements = game.settlements.clone
      player = game.current_player
      call
      missing_settlement = (old_settlements - game.settlements).first
      expect(missing_settlement).to eq(Settlement.new(spot_index: spot_index, owner: player))
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
      game.handle(SetResources.new(player: player, resource_values: { wool: 0, grain: 2, ore: 3, lumber: 0, brick: 0 }))
      game.handle(GrantSettlement.new(spot: spot_index, player: player))
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
      game.handle(SetResources.new(player: player, resource_values: { wool: 0, grain: 2, ore: 3, lumber: 0, brick: 0 }))
      game.handle(GrantSettlement.new(spot: spot_index, player: player))
    end

    it_behaves_like 'not mutating interaction'

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq('Action has not been taken')
    end
  end

  context 'when player has no resources' do
    before(:each) do
      game.handle(@setup_game_interactor)
      game.handle(SetTurn.new(turn: 10))
      game.handle(SetResources.new(player: player, resource_values: { wool: 0, grain: 0, ore: 0, lumber: 2, brick: 3 }))
      game.handle(GrantSettlement.new(spot: spot_index, player: player))
      game.handle(TakeAction.new)
    end

    it_behaves_like 'not mutating interaction'

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq('Player has not enough resources')
    end
  end

  context 'when player does not have settlement there' do
    before(:each) do
      game.handle(@setup_game_interactor)
      game.handle(SetTurn.new(turn: 10))
      game.handle(SetResources.new(player: player, resource_values: { wool: 0, grain: 2, ore: 3, lumber: 0, brick: 0 }))
      game.handle(GrantSettlement.new(spot: other_spot_index, player: player))
      game.handle(TakeAction.new)
    end

    it_behaves_like 'not mutating interaction'

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq('Player has no settlement on requesting spot')
    end
  end
end
