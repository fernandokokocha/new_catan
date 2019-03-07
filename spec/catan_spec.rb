# frozen_string_literal: true

describe Catan do
  let(:game) { Catan.new }

  context 'initially' do
    it 'is not setup' do
      expect(game.setup?).to be(false)
    end

    it 'has no players' do
      expect(game.players).to eq([])
    end
  end
end
