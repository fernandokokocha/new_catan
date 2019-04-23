# frozen_string_literal: true

class GameDeserializer
  attr_reader :hash, :players

  def initialize(hash)
    @hash = hash
  end

  def call
    @players = deserialize_players(hash[:players])
    Game.new.tap do |game|
      deserialize_state(game.state)
    end
  end

  def deserialize_state(state)
    state.setup = @hash[:setup]
    state.players = players
    state.settlements = deserialize_settlements(@hash[:settlements])
    state.roads = deserialize_roads(@hash[:roads])
    state.tiles = deserialize_tiles(@hash[:tiles])
    state.turn = @hash[:turn]
    state.action_taken = @hash[:action_taken]
  end

  def deserialize_players(players)
    players.map.with_index do |player, index|
      resources = deserialize_resources(player[:resources])
      Player.new(index: index, name: player[:name], color: player[:color], resources: resources)
    end
  end

  def deserialize_resources(resources)
    Resources.new(
      brick: resources[:brick],
      lumber: resources[:lumber],
      wool: resources[:wool],
      grain: resources[:grain],
      ore: resources[:ore]
    )
  end

  def deserialize_settlements(settlements)
    settlements.map do |settlement|
      owner = ArrayUtils.find_by_attribute(players, :name, settlement[:owner_name])
      Settlement.new(spot_index: settlement[:spot_index], owner: owner)
    end
  end

  def deserialize_roads(roads)
    roads.map do |road|
      owner = ArrayUtils.find_by_attribute(players, :name, road[:owner_name])
      Road.new(from: road[:from], to: road[:to], owner: owner)
    end
  end

  def deserialize_tiles(_tiles)
    # no need to deserialize - every set of tiles is the same (for now)
    Game.new.tiles
  end
end
