# frozen_string_literal: true

describe GameDeserializer do
  let(:serializer) { GameSerializer.new(game) }
  let(:deserializer) { GameDeserializer.new(hash) }

  let(:serialize) { serializer.call }
  subject(:call) { deserializer.call }

  context 'on intial game' do
    let(:game) { Game.new }
    let(:hash) { serialize }

    it 'serializes to JSON' do
      expect(call).to eq(game)
    end
  end
end
