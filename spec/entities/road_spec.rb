# frozen_string_literal: true

describe Road do
  let(:player) { Player.new(index: 0, name: 'Bartek', color: :orange) }
  let(:road) { Road.new(from: 1, to: 2, owner: player) }

  it 'equals itself' do
    expect(road).to eq(road)
  end

  it 'equals different road with the same fields' do
    expect(road).to eq(Road.new(from: 1, to: 2, owner: player))
  end

  it 'equals simetric road' do
    expect(road).to eq(Road.new(from: 2, to: 1, owner: player))
  end
end
