# frozen_string_literal: true

class GameSerializer
  def initialize(game)
    @game = game
  end

  def call
    {
      'setup' => @game.setup?,
      'players' => @game.players.map { |player| serialize_player(player) },
      'settlements' => @game.settlements.map { |settlement| serialize_settlement(settlement) },
      'cities' => @game.cities.map { |city| serialize_city(city) },
      'roads' => @game.roads.map { |road| serialize_road(road) },
      'tiles' => @game.tiles.sort_by(&:index).map { |tile| serialize_tile(tile) },
      'turn' => @game.turn,
      'action_taken' => @game.action_taken?,
      'cards' => @game.cards.map { |card| serialize_card(card) }
    }
  end

  def serialize_player(player)
    {
      'name' => player.name,
      'color' => player.color.to_s,
      'resources' => serialize_resources(player.resources)
    }
  end

  def serialize_resources(resources)
    {
      'brick' => resources.brick,
      'lumber' => resources.lumber,
      'wool' => resources.wool,
      'grain' => resources.grain,
      'ore' => resources.ore
    }
  end

  def serialize_settlement(settlement)
    {
      'spot_index' => settlement.spot_index,
      'owner_name' => settlement.owner.name
    }
  end

  def serialize_city(city)
    {
      'spot_index' => city.spot_index,
      'owner_name' => city.owner.name
    }
  end

  def serialize_road(road)
    {
      'from' => road.from,
      'to' => road.to,
      'owner_name' => road.owner.name
    }
  end

  def serialize_tile(tile)
    {
      'index' => tile.index,
      'resource' => tile.resource.to_s,
      'chit' => tile.chit
    }
  end

  def serialize_card(card)
    return { 'type' => 'victory' } if card.no_owner?

    {
      'type' => 'victory',
      'owner_name' => card.owner.name
    }
  end
end
