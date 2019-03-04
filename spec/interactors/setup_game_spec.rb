# frozen_string_literal: true

describe SetupGame do
  let(:interactor) { SetupGame.new }
  let(:response) { interactor.invoke }

  it 'can be invoked' do
    expect { interactor.invoke }.to_not raise_error
  end

  it 'returns a map' do
    expect(response[:map]).to eql(Map.new)
  end
end
