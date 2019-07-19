# frozen_string_literal: true

describe TurnTypeCalculator do
  shared_examples 'turn type calculator' do |turn, expected|
    let(:turn) { turn }

    it 'correctly calculates turn type' do
      expect(call).to be(expected)
    end
  end

  describe 'reversed_turn?' do
    subject(:call) { TurnTypeCalculator.new(players_count).reversed_turn?(turn) }

    context 'when two players' do
      let(:players_count) { 2 }

      it_behaves_like 'turn type calculator', 1, false
      it_behaves_like 'turn type calculator', 2, false
      it_behaves_like 'turn type calculator', 3, true
      it_behaves_like 'turn type calculator', 4, true
      it_behaves_like 'turn type calculator', 5, false
      it_behaves_like 'turn type calculator', 6, false
    end

    context 'when three players' do
      let(:players_count) { 3 }

      it_behaves_like 'turn type calculator', 1, false
      it_behaves_like 'turn type calculator', 2, false
      it_behaves_like 'turn type calculator', 3, false
      it_behaves_like 'turn type calculator', 4, true
      it_behaves_like 'turn type calculator', 5, true
      it_behaves_like 'turn type calculator', 6, true
      it_behaves_like 'turn type calculator', 7, false
      it_behaves_like 'turn type calculator', 8, false
      it_behaves_like 'turn type calculator', 9, false
    end

    context 'when four players' do
      let(:players_count) { 4 }

      it_behaves_like 'turn type calculator', 1, false
      it_behaves_like 'turn type calculator', 2, false
      it_behaves_like 'turn type calculator', 3, false
      it_behaves_like 'turn type calculator', 4, false
      it_behaves_like 'turn type calculator', 5, true
      it_behaves_like 'turn type calculator', 6, true
      it_behaves_like 'turn type calculator', 7, true
      it_behaves_like 'turn type calculator', 8, true
      it_behaves_like 'turn type calculator', 9, false
      it_behaves_like 'turn type calculator', 10, false
      it_behaves_like 'turn type calculator', 11, false
      it_behaves_like 'turn type calculator', 12, false
    end
  end

  describe 'regular_turn?' do
    subject(:call) { TurnTypeCalculator.new(players_count).regular_turn?(turn) }

    context 'when two players' do
      let(:players_count) { 2 }

      it_behaves_like 'turn type calculator', 1, false
      it_behaves_like 'turn type calculator', 2, false
      it_behaves_like 'turn type calculator', 3, false
      it_behaves_like 'turn type calculator', 4, false
      it_behaves_like 'turn type calculator', 5, true
      it_behaves_like 'turn type calculator', 6, true
    end

    context 'when three players' do
      let(:players_count) { 3 }

      it_behaves_like 'turn type calculator', 1, false
      it_behaves_like 'turn type calculator', 2, false
      it_behaves_like 'turn type calculator', 3, false
      it_behaves_like 'turn type calculator', 4, false
      it_behaves_like 'turn type calculator', 5, false
      it_behaves_like 'turn type calculator', 6, false
      it_behaves_like 'turn type calculator', 7, true
      it_behaves_like 'turn type calculator', 8, true
      it_behaves_like 'turn type calculator', 9, true
    end

    context 'when four players' do
      let(:players_count) { 4 }

      it_behaves_like 'turn type calculator', 1, false
      it_behaves_like 'turn type calculator', 2, false
      it_behaves_like 'turn type calculator', 3, false
      it_behaves_like 'turn type calculator', 4, false
      it_behaves_like 'turn type calculator', 5, false
      it_behaves_like 'turn type calculator', 6, false
      it_behaves_like 'turn type calculator', 7, false
      it_behaves_like 'turn type calculator', 8, false
      it_behaves_like 'turn type calculator', 9, true
      it_behaves_like 'turn type calculator', 10, true
      it_behaves_like 'turn type calculator', 11, true
      it_behaves_like 'turn type calculator', 12, true
    end
  end

  describe 'initial_turn?' do
    subject(:call) { TurnTypeCalculator.new(players_count).initial_turn?(turn) }

    context 'when two players' do
      let(:players_count) { 2 }

      it_behaves_like 'turn type calculator', 1, true
      it_behaves_like 'turn type calculator', 2, true
      it_behaves_like 'turn type calculator', 3, false
      it_behaves_like 'turn type calculator', 4, false
      it_behaves_like 'turn type calculator', 5, false
      it_behaves_like 'turn type calculator', 6, false
    end

    context 'when three players' do
      let(:players_count) { 3 }

      it_behaves_like 'turn type calculator', 1, true
      it_behaves_like 'turn type calculator', 2, true
      it_behaves_like 'turn type calculator', 3, true
      it_behaves_like 'turn type calculator', 4, false
      it_behaves_like 'turn type calculator', 5, false
      it_behaves_like 'turn type calculator', 6, false
      it_behaves_like 'turn type calculator', 7, false
      it_behaves_like 'turn type calculator', 8, false
      it_behaves_like 'turn type calculator', 9, false
    end

    context 'when four players' do
      let(:players_count) { 4 }

      it_behaves_like 'turn type calculator', 1, true
      it_behaves_like 'turn type calculator', 2, true
      it_behaves_like 'turn type calculator', 3, true
      it_behaves_like 'turn type calculator', 4, true
      it_behaves_like 'turn type calculator', 5, false
      it_behaves_like 'turn type calculator', 6, false
      it_behaves_like 'turn type calculator', 7, false
      it_behaves_like 'turn type calculator', 8, false
      it_behaves_like 'turn type calculator', 9, false
      it_behaves_like 'turn type calculator', 10, false
      it_behaves_like 'turn type calculator', 11, false
      it_behaves_like 'turn type calculator', 12, false
    end
  end
end
