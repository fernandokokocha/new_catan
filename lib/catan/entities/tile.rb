# frozen_string_literal: true

class Tile
  VALID_RESOURCES = [
    Resources::BRICK,
    Resources::LUMBER,
    Resources::WOOL,
    Resources::GRAIN,
    Resources::ORE
  ].freeze

  attr_reader :resource, :index

  def initialize(resource:, index:)
    @resource = resource
    @index = index
    raise ArgumentError, 'Invalid tile params' unless valid?
  end

  def valid?
    VALID_RESOURCES.include?(@resource)
  end

  def ==(other)
    (other.class == self.class) &&
      (other.resource == @resource) &&
      (other.index == @index)
  end
end
