# frozen_string_literal: true

describe GainResources do
  let(:game) { Game.new }
  let(:chit) { 2 }
  let(:interactor) { GainResources.new(chit: chit) }

  subject(:call) { game.handle(interactor) }

  context 'with valid data' do
    before(:each) do
      game.handle(@setup_game_interactor)
      game.handle(SetTurn.new(turn: 10))
    end

    context 'when no settlements around' do
      it_behaves_like 'mutating interaction'

      it 'returns success' do
        expect(call.success?).to be(true)
      end

      it 'sets action taken' do
        call
        expect(game.action_taken?).to be(true)
      end
    end

    context 'when one settlements around' do
      before(:each) do
        game.handle(BuildSettlement.new(player: player, spot: spot))
      end

      let(:player) { game.players[0] }
      let(:spot) { 1 }

      it 'returns success' do
        expect(call.success?).to be(true)
      end

      it 'sets action taken' do
        call
        expect(game.action_taken?).to be(true)
      end

      it 'gives resources to player' do
        call
        expected = Resources.new(
          brick: 1,
          lumber: 0,
          wool: 0,
          grain: 0,
          ore: 0
        )
        expect(player.resources).to eq(expected)
      end
    end

    context 'when many settlements around from same player' do
      before(:each) do
        game.handle(BuildSettlement.new(player: player, spot: spot))
        game.handle(BuildSettlement.new(player: player, spot: spot_2))
      end

      let(:player) { game.players[0] }
      let(:spot) { 1 }
      let(:spot_2) { 9 }

      it 'returns success' do
        expect(call.success?).to be(true)
      end

      it 'sets action taken' do
        call
        expect(game.action_taken?).to be(true)
      end

      it 'gives resources to player' do
        call
        expected = Resources.new(
          brick: 2,
          lumber: 0,
          wool: 0,
          grain: 0,
          ore: 0
        )
        expect(player.resources).to eq(expected)
      end
    end

    context 'when many settlements around from different players' do
      before(:each) do
        game.handle(BuildSettlement.new(player: player, spot: spot))
        game.handle(BuildSettlement.new(player: player_2, spot: spot_2))
      end

      let(:player) { game.players[0] }
      let(:player_2) { game.players[1] }
      let(:spot) { 1 }
      let(:spot_2) { 9 }

      it 'returns success' do
        expect(call.success?).to be(true)
      end

      it 'sets action taken' do
        call
        expect(game.action_taken?).to be(true)
      end

      it 'gives resources to player 1' do
        call
        expected = Resources.new(
          brick: 1,
          lumber: 0,
          wool: 0,
          grain: 0,
          ore: 0
        )
        expect(player.resources).to eq(expected)
      end

      it 'gives resources to player 2' do
        call
        expected = Resources.new(
          brick: 1,
          lumber: 0,
          wool: 0,
          grain: 0,
          ore: 0
        )
        expect(player_2.resources).to eq(expected)
      end
    end

    context 'when two settlements around two different tiles' do
      before(:each) do
        game.handle(BuildSettlement.new(player: player, spot: spot))
        game.handle(BuildSettlement.new(player: player, spot: spot_2))
      end

      let(:chit) { 3 }
      let(:player) { game.players[0] }
      let(:spot) { 9 }
      let(:spot_2) { 15 }

      it 'returns success' do
        expect(call.success?).to be(true)
      end

      it 'sets action taken' do
        call
        expect(game.action_taken?).to be(true)
      end

      it 'gives resources to player 1' do
        call
        expected = Resources.new(
          brick: 2,
          lumber: 0,
          wool: 0,
          grain: 0,
          ore: 0
        )
        expect(player.resources).to eq(expected)
      end
    end

    context 'when one settlement around two different tiles' do
      before(:each) do
        game.handle(BuildSettlement.new(player: player, spot: spot))
      end

      let(:chit) { 3 }
      let(:player) { game.players[0] }
      let(:spot) { 3 }

      it 'returns success' do
        expect(call.success?).to be(true)
      end

      it 'sets action taken' do
        call
        expect(game.action_taken?).to be(true)
      end

      it 'gives resources to player 1' do
        call
        expected = Resources.new(
          brick: 2,
          lumber: 0,
          wool: 0,
          grain: 0,
          ore: 0
        )
        expect(player.resources).to eq(expected)
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

  context 'when too early turn' do
    before(:each) do
      game.handle(@setup_game_interactor)
      game.handle(SetTurn.new(turn: 1))
    end

    it_behaves_like 'not mutating interaction'

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq('Invalid turn for this operation: 1')
    end
  end

  context 'when invalid chit' do
    before(:each) do
      game.handle(@setup_game_interactor)
      game.handle(SetTurn.new(turn: 10))
    end

    let(:chit) { -1 }

    it_behaves_like 'not mutating interaction'

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq('Invalid chit: -1')
    end
  end

  context 'when chit indicates desert' do
    before(:each) do
      game.handle(@setup_game_interactor)
      game.handle(SetTurn.new(turn: 10))
    end

    let(:chit) { 7 }

    it_behaves_like 'not mutating interaction'

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq('Chit indicates desert: 7')
    end
  end

  context 'when action already played' do
    before(:each) do
      game.handle(@setup_game_interactor)
      game.handle(SetTurn.new(turn: 10))
      game.handle(TakeAction.new)
    end

    it_behaves_like 'not mutating interaction'

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq('Action already taken')
    end
  end
end
