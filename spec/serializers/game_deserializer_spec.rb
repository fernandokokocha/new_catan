# frozen_string_literal: true

describe GameDeserializer do
  let(:serializer) { GameSerializer.new(game) }
  let(:deserializer) { GameDeserializer.new(hash) }

  let(:game) { Game.new }
  let(:hash) { serializer.call }
  subject(:call) { deserializer.call }

  context 'on intial game' do
    it 'deserializes to equal game object' do
      expect(call).to eq(game)
    end
  end

  context 'after 4 settle with road turns (no end turn)' do
    before(:each) do
      game.handle(@setup_game_interactor)
      game.handle(SettleWithRoad.new(settlement_spot: 1, road_extension_spot: 2))
      game.handle(EndTurn.new)
      game.handle(SettleWithRoad.new(settlement_spot: 3, road_extension_spot: 4))
      game.handle(EndTurn.new)
      game.handle(SettleWithRoad.new(settlement_spot: 5, road_extension_spot: 6))
      game.handle(EndTurn.new)
      game.handle(SettleWithRoad.new(settlement_spot: 7, road_extension_spot: 8))
    end

    it 'deserializes to equal game object' do
      expect(call).to eq(game)
    end
  end
end
