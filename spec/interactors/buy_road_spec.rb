# frozen_string_literal: true

describe BuyRoad do
  let(:game) { Game.new }
  let(:interactor) { BuyRoad.new(from_index: from_index, to_index: to_index) }
  let(:from_index) { 2 }
  let(:to_index) { 3 }
  let(:player) { game.current_player }
  let(:other_player) { game.players[0] }

  subject(:call) { game.handle(interactor) }

  context 'with valid data' do
    before(:each) do
      game.handle(@setup_game_interactor)
      game.handle(SetTurn.new(turn: 10))
      game.handle(SetResources.new(player: player, resource_values: { wool: 0, grain: 0, ore: 1, lumber: 2, brick: 1 }))
      game.handle(GrantRoad.new(player: player, from: 1, to: 2))
      game.handle(TakeAction.new)
    end

    it_behaves_like 'mutating interaction'

    it 'returns success' do
      expect(call.success?).to be(true)
    end

    it 'takes resources' do
      call
      expect(game.current_player.resources).to eq(Resources.new(wool: 0, grain: 0, ore: 1, lumber: 1, brick: 0))
    end

    it 'builds one road' do
      old_length = game.roads.length
      call
      expect(game.roads.length).to eq(old_length + 1)
    end

    it 'builds corrent road' do
      old_roads = game.roads.clone
      player = game.current_player
      call
      new_road = (game.roads - old_roads).first
      expect(new_road).to eq(Road.new(from: from_index, to: to_index, owner: player))
    end

    it 'does not untake action' do
      call
      expect(game.action_taken?).to be(true)
    end
  end

  context 'with valid data - symmetic road' do
    let(:from_index) { 3 }
    let(:to_index) { 2 }

    before(:each) do
      game.handle(@setup_game_interactor)
      game.handle(SetTurn.new(turn: 10))
      game.handle(SetResources.new(player: player, resource_values: { wool: 0, grain: 0, ore: 1, lumber: 2, brick: 1 }))
      game.handle(GrantRoad.new(player: player, from: 1, to: 2))
      game.handle(TakeAction.new)
    end

    it_behaves_like 'mutating interaction'

    it 'returns success' do
      expect(call.success?).to be(true)
    end

    it 'takes resources' do
      call
      expect(game.current_player.resources).to eq(Resources.new(wool: 0, grain: 0, ore: 1, lumber: 1, brick: 0))
    end

    it 'builds one road' do
      old_length = game.roads.length
      call
      expect(game.roads.length).to eq(old_length + 1)
    end

    it 'builds corrent road' do
      old_roads = game.roads.clone
      player = game.current_player
      call
      new_road = (game.roads - old_roads).first
      expect(new_road).to eq(Road.new(from: from_index, to: to_index, owner: player))
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
      game.handle(SetResources.new(player: player, resource_values: { wool: 0, grain: 0, ore: 1, lumber: 2, brick: 1 }))
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
      game.handle(SetResources.new(player: player, resource_values: { wool: 0, grain: 0, ore: 1, lumber: 2, brick: 1 }))
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

  context 'when no roads touches new road' do
    before(:each) do
      game.handle(@setup_game_interactor)
      game.handle(SetTurn.new(turn: 10))
      game.handle(SetResources.new(player: player, resource_values: { wool: 0, grain: 0, ore: 1, lumber: 2, brick: 1 }))
      game.handle(TakeAction.new)
    end

    it_behaves_like 'not mutating interaction'

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq('Player has no road connetion to new road')
    end
  end

  context 'when other players road touches' do
    before(:each) do
      game.handle(@setup_game_interactor)
      game.handle(SetTurn.new(turn: 10))
      game.handle(SetResources.new(player: player, resource_values: { wool: 0, grain: 0, ore: 1, lumber: 2, brick: 1 }))
      game.handle(GrantRoad.new(player: other_player, from: 1, to: 2))
      game.handle(TakeAction.new)
    end

    it_behaves_like 'not mutating interaction'

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq('Player has no road connetion to new road')
    end
  end

  context 'when road spot already taken' do
    before(:each) do
      game.handle(@setup_game_interactor)
      game.handle(SetTurn.new(turn: 10))
      game.handle(SetResources.new(player: player, resource_values: { wool: 0, grain: 0, ore: 1, lumber: 2, brick: 1 }))
      game.handle(GrantRoad.new(player: player, from: 1, to: 2))
      game.handle(GrantRoad.new(player: player, from: 2, to: 3))
      game.handle(TakeAction.new)
    end

    it_behaves_like 'not mutating interaction'

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq("Can't overbuild existing road")
    end
  end

  context 'when road requested with not bordering spots' do
    let(:from_index) { 2 }
    let(:to_index) { 4 }

    before(:each) do
      game.handle(@setup_game_interactor)
      game.handle(SetTurn.new(turn: 10))
      game.handle(SetResources.new(player: player, resource_values: { wool: 0, grain: 0, ore: 1, lumber: 2, brick: 1 }))
      game.handle(GrantRoad.new(player: player, from: 1, to: 2))
      game.handle(TakeAction.new)
    end

    it_behaves_like 'not mutating interaction'

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq("Spots don't border")
    end
  end
end
