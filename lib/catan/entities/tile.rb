# frozen_string_literal: true

class Tile
  VALID_RESOURCES = [
    ::Resources::BRICK,
    ::Resources::LUMBER,
    ::Resources::WOOL,
    ::Resources::GRAIN,
    ::Resources::ORE
  ].freeze

  DESERT = :desert

  attr_reader :index, :resource, :chit

  def initialize(index:, resource:, chit:)
    @index = index
    @resource = resource
    @chit = chit
    raise ArgumentError, 'Invalid tile params' unless valid?
  end

  def self.build_desert
    new(index: 1, resource: DESERT, chit: 7)
  end

  def valid?
    (VALID_RESOURCES + [DESERT]).include?(@resource)
  end

  def ==(other)
    (other.class == self.class) &&
      (other.index == @index) &&
      (other.resource == @resource) &&
      (other.chit == @chit)
  end
end
