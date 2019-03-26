# frozen_string_literal: true

describe SetupGame do
  let(:game) { Game.new }
  let(:player_names) { %w[Bartek Leo] }
  let(:interactor) { SetupGame.new(player_names: player_names) }

  subject(:call) { game.handle(interactor) }

  context 'invoked first time' do
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
      expect(game.players).to eq([Player.new(name: 'Bartek'), Player.new(name: 'Leo')])
    end
  end

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
