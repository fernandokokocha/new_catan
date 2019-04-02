# frozen_string_literal: true

describe SettleWithRoad do
  let(:game) { Game.new }
  let(:spot_index) { 1 }
  let(:other_spot_index) { 2 }
  let(:interactor) { SettleWithRoad.new(settlement_spot: spot_index, road_extension_spot: other_spot_index) }

  subject(:call) { game.handle(interactor) }

  context 'when game not set up' do
    it_behaves_like 'not mutating interaction'

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq('Game not initialized')
    end
  end

  context 'when game set up' do
    before(:each) { game.handle(@setup_game_interactor) }

    it_behaves_like 'mutating interaction'

    it 'returns success' do
      expect(call.success?).to be(true)
    end

    it 'settles one spot' do
      call
      expect(game.settlements.length).to eq(1)
    end

    it 'settles correct spot' do
      player = game.current_player
      call
      expect(game.settlements.first).to eq(Settlement.new(spot_index: 1, owner: player))
    end

    it 'builds one road' do
      call
      expect(game.roads.length).to eq(1)
    end

    it 'builds correct road' do
      player = game.current_player
      call
      expect(game.roads.first).to eq(Road.new(from: 1, to: 2, owner: player))
    end
  end

  context 'when spot is already taken' do
    before(:each) do
      game.handle(@setup_game_interactor)
      game.handle(SettleWithRoad.new(settlement_spot: spot_index, road_extension_spot: 6))
    end

    it_behaves_like 'not mutating interaction'

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq("Spot \##{spot_index}: is already settled")
    end
  end

  context 'when bordering spot is taken' do
    let(:bordering_spot) { 6 }

    before(:each) do
      game.handle(@setup_game_interactor)
      game.handle(SettleWithRoad.new(settlement_spot: bordering_spot, road_extension_spot: 5))
    end

    it_behaves_like 'not mutating interaction'

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq("Spot \##{spot_index}: bordering spot \##{bordering_spot} is already settled")
    end
  end
end
