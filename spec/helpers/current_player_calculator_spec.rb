# frozen_string_literal: true

describe CurrentPlayerCalculator do
  subject(:call) { CurrentPlayerCalculator.calc_index(turn, players_count) }

  shared_examples 'player index calculator' do |turn, player_index|
    let(:turn) { turn }

    it 'correctly calculates current player index' do
      expect(call).to be(player_index)
    end
  end

  context 'when two players' do
    let(:players_count) { 2 }

    it_behaves_like 'player index calculator', 1, 0
    it_behaves_like 'player index calculator', 2, 1
    it_behaves_like 'player index calculator', 3, 1
    it_behaves_like 'player index calculator', 4, 0
    it_behaves_like 'player index calculator', 5, 0
    it_behaves_like 'player index calculator', 6, 1
    it_behaves_like 'player index calculator', 7, 0
    it_behaves_like 'player index calculator', 8, 1
  end

  context 'when three players' do
    let(:players_count) { 3 }

    it_behaves_like 'player index calculator', 1, 0
    it_behaves_like 'player index calculator', 2, 1
    it_behaves_like 'player index calculator', 3, 2
    it_behaves_like 'player index calculator', 4, 2
    it_behaves_like 'player index calculator', 5, 1
    it_behaves_like 'player index calculator', 6, 0
    it_behaves_like 'player index calculator', 7, 0
    it_behaves_like 'player index calculator', 8, 1
    it_behaves_like 'player index calculator', 9, 2
    it_behaves_like 'player index calculator', 10, 0
    it_behaves_like 'player index calculator', 11, 1
    it_behaves_like 'player index calculator', 12, 2
  end

  context 'when four players' do
    let(:players_count) { 4 }

    it_behaves_like 'player index calculator', 1, 0
    it_behaves_like 'player index calculator', 2, 1
    it_behaves_like 'player index calculator', 3, 2
    it_behaves_like 'player index calculator', 4, 3
    it_behaves_like 'player index calculator', 5, 3
    it_behaves_like 'player index calculator', 6, 2
    it_behaves_like 'player index calculator', 7, 1
    it_behaves_like 'player index calculator', 8, 0
    it_behaves_like 'player index calculator', 9, 0
    it_behaves_like 'player index calculator', 10, 1
    it_behaves_like 'player index calculator', 11, 2
    it_behaves_like 'player index calculator', 12, 3
    it_behaves_like 'player index calculator', 13, 0
    it_behaves_like 'player index calculator', 14, 1
    it_behaves_like 'player index calculator', 15, 2
    it_behaves_like 'player index calculator', 16, 3
  end
end
