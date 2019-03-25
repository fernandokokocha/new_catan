# frozen_string_literal: true

describe SettleWithRoad do
  let(:game) { Game.new }
  let(:spot_index) { 1 }
  let(:other_spot_index) { 2 }
  let(:interactor) { SettleWithRoad.new(spot_index, other_spot_index) }

  subject(:call) { game.handle(interactor) }

  context 'on not setup game' do
    it 'raises error' do
      expect { call }.to raise_error(SettleWithRoad::GameNotInitialized)
    end
  end

  context 'on valid' do
    before(:each) { game.handle(SetupGame.new(%w[Bartek Leo])) }

    it 'returns true' do
      expect(call).to be(true)
    end

    it 'settles one spot' do
      call
      expect(game.settlements.length).to eq(1)
    end

    it 'settles correct spot' do
      call
      expect(game.settlements.first).to eq(Settlement.new(spot_index: 1))
    end

    it 'builds one road' do
      call
      expect(game.roads.length).to eq(1)
    end

    it 'builds correct road' do
      call
      expect(game.roads.first).to eq(Road.new(from: 1, to: 2))
    end
  end

  context 'spot is already taken' do
    before(:each) do
      game.handle(SetupGame.new(%w[Bartek Leo]))
      game.handle(SettleWithRoad.new(spot_index, 6))
    end

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it "doesn't change the state" do
      old = game.state
      call
      new = game.state
      expect(new).to be(old)
    end
  end
end
