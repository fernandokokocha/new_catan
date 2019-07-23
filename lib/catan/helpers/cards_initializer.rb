# frozen_string_literal: true

module CardsInitializer
  CARDS_COUNT = 25

  def self.create_set
    Array.new(CARDS_COUNT).map do
      Card.new
    end
  end
end
