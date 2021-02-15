# frozen_string_literal: true

class ScoreCalculator
  def initialize(settlements:, cities:, cards:)
    @settlements = settlements
    @cities = cities
    @cards = cards
  end

  def calc(player)
    settlements_count(player) + (2 * cities_count(player)) + victory_cards_count(player)
  end

  def settlements_count(player)
    @settlements.select { |settlement| settlement.owner.equal?(player) }.count
  end

  def cities_count(player)
    @cities.select { |city| city.owner.equal?(player) }.count
  end

  def victory_cards_count(player)
    @cards.select { |card| card.victory? && card.owned_by?(player) }.count
  end
end
