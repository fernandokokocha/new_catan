# frozen_string_literal: true

describe Road do
  let(:from) { 1 }
  let(:to) { 2 }
  let(:other_spot) { 3 }

  let(:player) { Player.new(index: 0, name: 'Bartek', color: :orange) }
  let(:road) { Road.new(from: from, to: to, owner: player) }

  it 'equals itself' do
    expect(road).to eq(road)
  end

  it 'equals different road with the same attributes' do
    expect(road).to eq(Road.new(from: from, to: to, owner: player))
  end

  it 'equals symmetric road' do
    expect(road).to eq(Road.new(from: to, to: from, owner: player))
  end

  it 'is adjacent to its from' do
    expect(road).to be_adjacent_to(from)
  end

  it 'is adjacent to its to' do
    expect(road).to be_adjacent_to(to)
  end

  it 'is not adjacent to other spots' do
    expect(road).not_to be_adjacent_to(other_spot)
  end
end
