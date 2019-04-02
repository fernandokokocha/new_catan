# frozen_string_literal: true

describe Game do
  let(:game) { Game.new }

  context 'when just created' do
    it 'is not setup' do
      expect(game.setup?).to be(false)
    end

    it 'has no players' do
      expect(game.players).to eq([])
    end

    it 'has no settlements' do
      expect(game.settlements).to eq([])
    end

    it 'has no roads' do
      expect(game.roads).to eq([])
    end
  end
end
