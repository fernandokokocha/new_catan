# frozen_string_literal: true

require 'json'

describe GameSerializer do
  let(:serializator) { GameSerializer.new(game) }

  subject(:call) { serializator.call }

  context 'on intial game' do
    let(:game) { Game.new }
    let(:expected) do
      {
        setup: false,
        players: [],
        settlements: [],
        roads: [],
        tiles: tiles,
        turn: 1,
        action_taken: false
      }
    end

    it 'serializes to JSON' do
      expect(call).to eq(expected)
    end
  end

  context 'after 4 settle with road turns' do
    let(:game) { Game.new }

    before(:each) do
      game.handle(@setup_game_interactor)
      game.handle(SettleWithRoad.new(settlement_spot: 1, road_extension_spot: 2))
      game.handle(EndTurn.new)
      game.handle(SettleWithRoad.new(settlement_spot: 3, road_extension_spot: 4))
      game.handle(EndTurn.new)
      game.handle(SettleWithRoad.new(settlement_spot: 5, road_extension_spot: 6))
      game.handle(EndTurn.new)
      game.handle(SettleWithRoad.new(settlement_spot: 7, road_extension_spot: 8))
      game.handle(EndTurn.new)
    end

    let(:expected) do
      {
        setup: true,
        players: [
          {
            name: 'Bartek',
            color: :orange,
            resources: { brick: 2, lumber: 2, wool: 0, grain: 0, ore: 1 }
          },
          {
            name: 'Leo',
            color: :blue,
            resources: { brick: 2, lumber: 2, wool: 0, grain: 0, ore: 0 }
          }
        ],
        settlements: [
          { spot_index: 1, owner_name: 'Bartek' },
          { spot_index: 3, owner_name: 'Leo' },
          { spot_index: 5, owner_name: 'Leo' },
          { spot_index: 7, owner_name: 'Bartek' }
        ],
        roads: [
          { from: 1, to: 2, owner_name: 'Bartek' },
          { from: 3, to: 4, owner_name: 'Leo' },
          { from: 5, to: 6, owner_name: 'Leo' },
          { from: 7, to: 8, owner_name: 'Bartek' }
        ],
        tiles: tiles,
        turn: 5,
        action_taken: false
      }
    end

    it 'serializes to JSON' do
      call
      expect(call).to eq(expected)
    end
  end

  def tiles
    [
      {
        index: 1,
        resource: :desert,
        chit: 7
      },
      {
        index: 2,
        resource: :brick,
        chit: 2
      },
      {
        index: 3,
        resource: :brick,
        chit: 3
      },
      {
        index: 4,
        resource: :brick,
        chit: 3
      },
      {
        index: 5,
        resource: :lumber,
        chit: 4
      },
      {
        index: 6,
        resource: :lumber,
        chit: 4
      },
      {
        index: 7,
        resource: :lumber,
        chit: 5
      },
      {
        index: 8,
        resource: :lumber,
        chit: 5
      },
      {
        index: 9,
        resource: :wool,
        chit: 6
      },
      {
        index: 10,
        resource: :wool,
        chit: 6
      },
      {
        index: 11,
        resource: :wool,
        chit: 8
      },
      {
        index: 12,
        resource: :wool,
        chit: 8
      },
      {
        index: 13,
        resource: :grain,
        chit: 9
      },
      {
        index: 14,
        resource: :grain,
        chit: 9
      },
      {
        index: 15,
        resource: :grain,
        chit: 10
      },
      {
        index: 16,
        resource: :grain,
        chit: 10
      },
      {
        index: 17,
        resource: :ore,
        chit: 11
      },
      {
        index: 18,
        resource: :ore,
        chit: 11
      },
      {
        index: 19,
        resource: :ore,
        chit: 12
      }
    ]
  end
end