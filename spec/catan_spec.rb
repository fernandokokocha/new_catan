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

    it 'has no current players' do
      expect(game.current_player).to eq(nil)
    end

    it 'has no settlements' do
      expect(game.settlements).to eq([])
    end

    it 'has no roads' do
      expect(game.roads).to eq([])
    end

    it 'has 19 tiles' do
      expect(game.tiles.length).to be(19)
    end

    it 'has first turn' do
      expect(game.turn).to be(1)
    end

    it 'has no action taken' do
      expect(game.action_taken?).to be(false)
    end
  end
end
