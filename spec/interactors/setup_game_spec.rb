# frozen_string_literal: true

describe SetupGame do
  let(:game) { Game.new }
  let(:player_1) { { name: 'Bartek', color: :orange } }
  let(:player_2) { { name: 'Leo', color: :blue } }
  let(:players) { [player_1, player_2] }
  let(:interactor) { SetupGame.new(players: players) }

  subject(:call) { game.handle(interactor) }

  context 'valid data' do
    it_behaves_like 'mutating interaction'

    it 'returns success' do
      expect(call.success?).to be(true)
    end

    it 'sets up game' do
      call
      expect(game.setup?).to be(true)
    end

    it 'sets up players' do
      call
      expect(game.players.length).to be(2)
      expect(game.players[0]).to eq(Player.new(name: 'Bartek', color: :orange))
      expect(game.players[1]).to eq(Player.new(name: 'Leo', color: :blue))
    end
  end

  context 'too few players' do
    let(:players) { [player_1] }

    it_behaves_like 'not mutating interaction'

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq('Too few players: 1 instead of required at least 2')
    end
  end

  context 'invalid color of player' do
    let(:player_1) { { name: 'Bartek', color: :green } }

    it_behaves_like 'not mutating interaction'

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq('Invalid player color: green of player Bartek')
    end
  end

  context 'too many players'

  context 'invoked second time' do
    before(:each) { game.handle(interactor) }

    it_behaves_like 'not mutating interaction'

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq('Game already initialized')
    end
  end
end
