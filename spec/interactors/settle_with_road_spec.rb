# frozen_string_literal: true

describe SettleWithRoad do
  let(:game) { Game.new }
  let(:spot_index) { 1 }
  let(:other_spot_index) { 2 }
  let(:interactor) { SettleWithRoad.new(settlement_spot: spot_index, road_extension_spot: other_spot_index) }

  subject(:call) { game.handle(interactor) }

  context 'with valid data' do
    context 'when on clear state' do
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

      it 'adds resources to current player' do
        current_player_name = game.current_player.name
        call
        previous_player = game.find_player_by_name(current_player_name)
        expected = Resources.new(
          brick: 1,
          lumber: 1,
          wool: 0,
          grain: 0,
          ore: 0
        )
        expect(previous_player.resources).to eq(expected)
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

      it 'sets action taken' do
        call
        expect(game.action_taken?).to be(true)
      end
    end

    context 'when on not clear state' do
      before(:each) do
        game.handle(@setup_game_interactor)
        game.handle(SettleWithRoad.new(settlement_spot: 3, road_extension_spot: 4))
        game.handle(EndTurn.new)
      end

      it_behaves_like 'mutating interaction'

      it 'returns success' do
        expect(call.success?).to be(true)
      end

      it 'settles one spot' do
        old_length = game.settlements.length
        call
        expect(game.settlements.length).to eq(old_length + 1)
      end

      it 'settles correct spot' do
        old_settlements = game.settlements.clone
        player = game.current_player
        call
        new_settlement = (game.settlements - old_settlements).first
        expect(new_settlement).to eq(Settlement.new(spot_index: 1, owner: player))
      end

      it 'adds resources to current player' do
        current_player_name = game.current_player.name
        call
        previous_player = game.find_player_by_name(current_player_name)
        expected = Resources.new(
          brick: 1,
          lumber: 1,
          wool: 0,
          grain: 0,
          ore: 0
        )
        expect(previous_player.resources).to eq(expected)
      end

      it 'builds one road' do
        old_length = game.roads.length
        call
        expect(game.roads.length).to eq(old_length + 1)
      end

      it 'builds correct road' do
        old_roads = game.roads.clone
        player = game.current_player
        call
        new_road = (game.roads - old_roads).first
        expect(new_road).to eq(Road.new(from: 1, to: 2, owner: player))
      end

      it 'sets action taken' do
        call
        expect(game.action_taken?).to be(true)
      end
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

  context 'when invalid turn' do
    before(:each) do
      game.handle(@setup_game_interactor)
      game.state.turn = 10
    end

    it_behaves_like 'not mutating interaction'

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq('Invalid turn for this operation: 10')
    end
  end

  context 'when action already taken in this turn' do
    before(:each) do
      game.handle(@setup_game_interactor)
      game.handle(SettleWithRoad.new(settlement_spot: 3, road_extension_spot: 4))
    end

    it_behaves_like 'not mutating interaction'

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq('Action already taken')
    end
  end

  describe 'turn validation' do
    shared_context 'implmenents turn validity' do |turn, validity|
      it 'knows when turn is valid' do
        game.handle(SetTurn.new(turn: turn))
        expect(call.success?).to be(validity)
      end
    end

    context 'when two players' do
      before(:each) { game.handle(@setup_game_two_players_interactor) }

      let(:players_fixtures) { @player_params_fixtures_two_players }

      it_behaves_like 'implmenents turn validity', 1, true
      it_behaves_like 'implmenents turn validity', 2, true
      it_behaves_like 'implmenents turn validity', 3, true
      it_behaves_like 'implmenents turn validity', 4, true
      it_behaves_like 'implmenents turn validity', 5, false
      it_behaves_like 'implmenents turn validity', 6, false
    end
  end

  context 'when spot is already taken' do
    before(:each) do
      game.handle(@setup_game_interactor)
      game.handle(SettleWithRoad.new(settlement_spot: spot_index, road_extension_spot: 6))
      game.handle(EndTurn.new)
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
      game.handle(EndTurn.new)
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
