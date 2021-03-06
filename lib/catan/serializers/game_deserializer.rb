# frozen_string_literal: true

class GameDeserializer
  attr_reader :players

  def initialize(hash)
    @hash = hash
  end

  def call
    @players = deserialize_players(@hash.fetch('players'))
    Game.new.tap do |game|
      deserialize_state(game.state)
    end
  end

  def deserialize_state(state)
    state.setup = @hash.fetch('setup')
    state.players = players
    state.settlements = deserialize_settlements(@hash.fetch('settlements'))
    state.cities = deserialize_cities(@hash.fetch('cities'))
    state.roads = deserialize_roads(@hash.fetch('roads'))
    state.tiles = deserialize_tiles(@hash.fetch('tiles'))
    state.turn = @hash.fetch('turn')
    state.action_taken = @hash.fetch('action_taken')
    state.cards = deserialize_cards(@hash.fetch('cards'))
  end

  def deserialize_players(players)
    players.map.with_index do |player, index|
      resources = deserialize_resources(player.fetch('resources'))
      Player.new(index: index, name: player.fetch('name'), color: player.fetch('color'), resources: resources)
    end
  end

  def deserialize_resources(resources)
    Resources.new(
      brick: resources.fetch('brick'),
      lumber: resources.fetch('lumber'),
      wool: resources.fetch('wool'),
      grain: resources.fetch('grain'),
      ore: resources.fetch('ore')
    )
  end

  def deserialize_settlements(settlements)
    settlements.map do |settlement|
      owner = ArrayUtils.find_by_attribute(players, :name, settlement.fetch('owner_name'))
      Settlement.new(spot_index: settlement.fetch('spot_index'), owner: owner)
    end
  end

  def deserialize_cities(cities)
    cities.map do |city|
      owner = ArrayUtils.find_by_attribute(players, :name, city.fetch('owner_name'))
      City.new(spot_index: city.fetch('spot_index'), owner: owner)
    end
  end

  def deserialize_roads(roads)
    roads.map do |road|
      owner = ArrayUtils.find_by_attribute(players, :name, road.fetch('owner_name'))
      Road.new(from: road.fetch('from'), to: road.fetch('to'), owner: owner)
    end
  end

  def deserialize_tiles(_tiles)
    # no need to deserialize - every set of tiles is the same (for now)
    Game.new.tiles
  end

  def deserialize_cards(cards)
    cards.map do |card|
      owner_name = card['owner_name']
      Card.new.tap do |card_entity|
        if owner_name.is_a?(String)
          owner = ArrayUtils.find_by_attribute(players, :name, owner_name)
          card_entity.give(owner)
        end
      end
    end
  end
end
