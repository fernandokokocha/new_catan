# frozen_string_literal: true

describe GetGameState do
  let(:interactor) { GetGameState.new }
  let(:response) { interactor.invoke }

  it 'raises error' do
    expect { interactor.invoke }.to raise_error(GetGameState::UnitializedGame)
  end
end
