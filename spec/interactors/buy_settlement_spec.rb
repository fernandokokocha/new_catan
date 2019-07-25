# frozen_string_literal: true

describe BuySettlement do
  let(:game) { Game.new }
  let(:interactor) { BuySettlement.new(spot_index: spot_index) }
  let(:spot_index) { 1 }
  let(:player) { game.current_player }
  let(:other_player) { game.players[0] }

  subject(:call) { game.handle(interactor) }

  context 'with valid data' do
    before(:each) do
      game.handle(@setup_game_interactor)
      game.handle(SetTurn.new(turn: 10))
      game.handle(SetResources.new(player: player, resource_values: { wool: 3, grain: 2, ore: 0, lumber: 3, brick: 2 }))
      game.handle(GrantRoad.new(player: player, from: 1, to: 2))
      game.handle(TakeAction.new)
    end

    it_behaves_like 'mutating interaction'

    it 'returns success' do
      expect(call.success?).to be(true)
    end

    it 'takes resources' do
      call
      expect(game.current_player.resources).to eq(Resources.new(wool: 2, grain: 1, ore: 0, lumber: 2, brick: 1))
    end

    it 'builds one settlement' do
      old_length = game.settlements.length
      call
      expect(game.settlements.length).to eq(old_length + 1)
    end

    it 'builds corrent settlement' do
      old_settlements = game.settlements.clone
      player = game.current_player
      call
      new_settlement = (game.settlements - old_settlements).first
      expect(new_settlement).to eq(Settlement.new(spot_index: spot_index, owner: player))
    end

    it 'does not untake action' do
      call
      expect(game.action_taken?).to be(true)
    end
  end

  context 'with valid data - symmetric road' do
    before(:each) do
      game.handle(@setup_game_interactor)
      game.handle(SetTurn.new(turn: 10))
      game.handle(SetResources.new(player: player, resource_values: { wool: 3, grain: 2, ore: 0, lumber: 3, brick: 2 }))
      game.handle(GrantRoad.new(player: player, from: 2, to: 1))
      game.handle(TakeAction.new)
    end

    it_behaves_like 'mutating interaction'

    it 'returns success' do
      expect(call.success?).to be(true)
    end

    it 'takes resources' do
      call
      expect(game.current_player.resources).to eq(Resources.new(wool: 2, grain: 1, ore: 0, lumber: 2, brick: 1))
    end

    it 'builds one settlement' do
      old_length = game.settlements.length
      call
      expect(game.settlements.length).to eq(old_length + 1)
    end

    it 'builds corrent settlement' do
      old_settlements = game.settlements.clone
      player = game.current_player
      call
      new_settlement = (game.settlements - old_settlements).first
      expect(new_settlement).to eq(Settlement.new(spot_index: spot_index, owner: player))
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
      game.handle(SetResources.new(player: player, resource_values: { wool: 3, grain: 2, ore: 0, lumber: 3, brick: 2 }))
      game.handle(GrantRoad.new(player: player, from: 1, to: 2))
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
      game.handle(SetResources.new(player: player, resource_values: { wool: 3, grain: 2, ore: 0, lumber: 3, brick: 2 }))
      game.handle(GrantRoad.new(player: player, from: 1, to: 2))
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
      game.handle(SetResources.new(player: player, resource_values: { wool: 0, grain: 0, ore: 0, lumber: 0, brick: 0 }))
      game.handle(GrantRoad.new(player: player, from: 1, to: 2))
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

  context 'when spot already taken' do
    before(:each) do
      game.handle(@setup_game_interactor)
      game.handle(SetTurn.new(turn: 10))
      game.handle(SetResources.new(player: player, resource_values: { wool: 3, grain: 2, ore: 0, lumber: 3, brick: 2 }))
      game.handle(GrantRoad.new(player: player, from: 1, to: 2))
      game.handle(GrantSettlement.new(player: player, spot: spot_index))
      game.handle(TakeAction.new)
    end

    it_behaves_like 'not mutating interaction'

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq('Spot #1: is already settled')
    end
  end

  context 'when bordering spot already taken' do
    before(:each) do
      game.handle(@setup_game_interactor)
      game.handle(SetTurn.new(turn: 10))
      game.handle(SetResources.new(player: player, resource_values: { wool: 3, grain: 2, ore: 0, lumber: 3, brick: 2 }))
      game.handle(GrantRoad.new(player: player, from: 1, to: 2))
      game.handle(GrantSettlement.new(player: player, spot: 2))
      game.handle(TakeAction.new)
    end

    it_behaves_like 'not mutating interaction'

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq('Spot #1: bordering spot #2 is already settled')
    end
  end

  context 'when no roads' do
    before(:each) do
      game.handle(@setup_game_interactor)
      game.handle(SetTurn.new(turn: 10))
      game.handle(SetResources.new(player: player, resource_values: { wool: 3, grain: 2, ore: 0, lumber: 3, brick: 2 }))
      game.handle(TakeAction.new)
    end

    it_behaves_like 'not mutating interaction'

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq("No player's road leads to spot #1")
    end
  end

  context 'when other players roads leads to spot' do
    before(:each) do
      game.handle(@setup_game_interactor)
      game.handle(SetTurn.new(turn: 10))
      game.handle(SetResources.new(player: player, resource_values: { wool: 3, grain: 2, ore: 0, lumber: 3, brick: 2 }))
      game.handle(GrantRoad.new(player: other_player, from: 1, to: 2))
      game.handle(TakeAction.new)
    end

    it_behaves_like 'not mutating interaction'

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq("No player's road leads to spot #1")
    end
  end

  context 'when player has other roads, none touching' do
    before(:each) do
      game.handle(@setup_game_interactor)
      game.handle(SetTurn.new(turn: 10))
      game.handle(SetResources.new(player: player, resource_values: { wool: 3, grain: 2, ore: 0, lumber: 3, brick: 2 }))
      game.handle(GrantRoad.new(player: player, from: 3, to: 4))
      game.handle(GrantRoad.new(player: player, from: 5, to: 6))
      game.handle(TakeAction.new)
    end

    it_behaves_like 'not mutating interaction'

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq("No player's road leads to spot #1")
    end
  end
end
