# frozen_string_literal: true

describe SetupGame do
  let(:state) { State.new }
  let(:interactor) { SetupGame }

  it 'can be invoked' do
    expect { interactor.invoke(state) }.to_not raise_error
  end

  it 'returns true' do
    expect(interactor.invoke(state)).to eql(true)
  end

  context 'invoked second time' do
    before(:each) do
      interactor.invoke(state)
    end

    it 'raises error' do
      expect { interactor.invoke(state) }.to raise_error(SetupGame::GameAlreadyInitialized)
    end
  end
end
