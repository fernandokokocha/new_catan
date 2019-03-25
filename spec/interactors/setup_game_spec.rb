# frozen_string_literal: true

describe SetupGame do
  let(:game) { Game.new }
  let(:player_names) { %w[Bartek Leo] }
  let(:interactor) { SetupGame.new(player_names) }

  subject(:call) { game.handle(interactor) }

  it 'can be invoked' do
    expect { call }.to_not raise_error
  end

  it 'returns true' do
    expect(call).to be(true)
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
    it 'raises error' do
      game.handle(interactor)
      expect { call }.to raise_error(SetupGame::GameAlreadyInitialized)
    end
  end
end
