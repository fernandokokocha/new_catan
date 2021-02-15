# frozen_string_literal: true

require 'json'

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

    context 'when serialized to json' do
      let(:json) { serializer.call.to_json }
      let(:hash) { JSON.parse(json) }

      it 'deserializes from json' do
        expect(call).to eq(game)
      end
    end
  end

  context 'after 4 cards are granted' do
    before(:each) do
      game.handle(@setup_game_interactor)
      game.handle(GrantCard.new(player: game.players[0]))
      game.handle(GrantCard.new(player: game.players[0]))
      game.handle(GrantCard.new(player: game.players[0]))
      game.handle(GrantCard.new(player: game.players[1]))
    end

    it 'deserializes to equal game object' do
      expect(call).to eq(game)
    end

    context 'when serialized to json' do
      let(:json) { serializer.call.to_json }
      let(:hash) { JSON.parse(json) }

      it 'deserializes from json' do
        expect(call).to eq(game)
      end
    end
  end

  context 'after cities are built' do
    before(:each) do
      game.handle(@setup_game_interactor)
      game.handle(GrantCity.new(spot: 1, player: game.players[0]))
      game.handle(GrantCity.new(spot: 10, player: game.players[1]))
    end

    it 'deserializes to equal game object' do
      expect(call).to eq(game)
    end

    context 'when serialized to json' do
      let(:json) { serializer.call.to_json }
      let(:hash) { JSON.parse(json) }

      it 'deserializes from json' do
        expect(call).to eq(game)
      end
    end
  end
end
