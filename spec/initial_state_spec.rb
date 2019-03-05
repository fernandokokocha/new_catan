# frozen_string_literal: true

describe 'initial state' do
  let(:game) { Catan.new }

  it 'is not setup' do
    expect(game.state.setup?).to be(false)
  end
end
