# frozen_string_literal: true

describe SetupGame do
  let(:game) { Game.new }
  let(:player_names) { %w[Bartek Leo] }
  let(:interactor) { SetupGame.new(player_names: player_names) }

  subject(:call) { game.handle(interactor) }

  it 'returns success' do
    expect(call.success?).to be(true)
  end

  it 'sets up game' do
    call
    expect(game.setup?).to be(true)
  end

  it 'sets up players' do
    call
    expect(game.players).to eq([{ name: 'Bartek' }, { name: 'Leo' }])
  end

  it 'is immutable' do
    old_state = game.state
    call
    expect(game.state).to_not be(old_state)
  end

  context 'invoked second time' do
    before(:each) { game.handle(interactor) }

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq('Game already initialized')
    end
  end
end
