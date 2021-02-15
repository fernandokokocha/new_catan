# frozen_string_literal: true

describe ScoreCalculator do
  subject(:call) { ScoreCalculator.new(settlements: settlements, cities: cities, cards: cards).calc(player) }

  let(:game) { Game.new }
  let(:settlements) { game.settlements }
  let(:cities) { game.cities }
  let(:cards) { game.cards }
  let(:made_up_player) { Player.new(index: 0, name: 'Krzycho', color: :orange) }

  shared_examples 'score calculator' do |score|
    it 'correctly calculates current player index' do
      expect(call).to be(score)
    end
  end

  context 'when null case' do
    let(:cards) { [] }
    let(:settlements) { [] }

    it_behaves_like 'score calculator', 0 do let(:player) { nil } end
    it_behaves_like 'score calculator', 0 do let(:player) { made_up_player } end
  end

  context 'when game not initialized' do
    let(:game) { Game.new }
    let(:settlements) { game.settlements }
    let(:cards) { game.cards }

    it_behaves_like 'score calculator', 0 do let(:player) { nil } end
    it_behaves_like 'score calculator', 0 do let(:player) { made_up_player } end
    it_behaves_like 'score calculator', 0 do let(:player) { game.players[0] } end
    it_behaves_like 'score calculator', 0 do let(:player) { game.players[1] } end
  end

  context 'when game initialized' do
    before(:each) do
      game.handle(@setup_game_interactor)
    end

    it_behaves_like 'score calculator', 0 do let(:player) { nil } end
    it_behaves_like 'score calculator', 0 do let(:player) { made_up_player } end
    it_behaves_like 'score calculator', 0 do let(:player) { game.players[0] } end
    it_behaves_like 'score calculator', 0 do let(:player) { game.players[1] } end
  end

  context 'when some settlements' do
    before(:each) do
      game.handle(@setup_game_interactor)
      game.handle(GrantSettlement.new(player: game.players[0], spot: 1))
      game.handle(GrantSettlement.new(player: game.players[0], spot: 3))
      game.handle(GrantSettlement.new(player: game.players[1], spot: 5))
    end

    it_behaves_like 'score calculator', 0 do let(:player) { nil } end
    it_behaves_like 'score calculator', 0 do let(:player) { made_up_player } end
    it_behaves_like 'score calculator', 2 do let(:player) { game.players[0] } end
    it_behaves_like 'score calculator', 1 do let(:player) { game.players[1] } end
  end

  context 'when some cards' do
    before(:each) do
      game.handle(@setup_game_interactor)
      game.handle(GrantCard.new(player: game.players[0]))
      game.handle(GrantCard.new(player: game.players[1]))
      game.handle(GrantCard.new(player: game.players[1]))
    end

    it_behaves_like 'score calculator', 0 do let(:player) { nil } end
    it_behaves_like 'score calculator', 0 do let(:player) { made_up_player } end
    it_behaves_like 'score calculator', 1 do let(:player) { game.players[0] } end
    it_behaves_like 'score calculator', 2 do let(:player) { game.players[1] } end
  end

  context 'when some settlements and cards' do
    before(:each) do
      game.handle(@setup_game_interactor)
      game.handle(GrantSettlement.new(player: game.players[1], spot: 1))
      game.handle(GrantSettlement.new(player: game.players[1], spot: 3))
      game.handle(GrantSettlement.new(player: game.players[1], spot: 5))

      game.handle(GrantCard.new(player: game.players[0]))
      game.handle(GrantCard.new(player: game.players[0]))
      game.handle(GrantCard.new(player: game.players[1]))
    end

    it_behaves_like 'score calculator', 0 do let(:player) { nil } end
    it_behaves_like 'score calculator', 0 do let(:player) { made_up_player } end
    it_behaves_like 'score calculator', 2 do let(:player) { game.players[0] } end
    it_behaves_like 'score calculator', 4 do let(:player) { game.players[1] } end
  end

  context 'when some settlements, cards and cities' do
    before(:each) do
      game.handle(@setup_game_interactor)
      game.handle(GrantSettlement.new(player: game.players[1], spot: 1))
      game.handle(GrantSettlement.new(player: game.players[1], spot: 3))

      game.handle(GrantCity.new(player: game.players[0], spot: 5))
      game.handle(GrantCity.new(player: game.players[1], spot: 10))

      game.handle(GrantCard.new(player: game.players[0]))
      game.handle(GrantCard.new(player: game.players[0]))
      game.handle(GrantCard.new(player: game.players[1]))
    end

    it_behaves_like 'score calculator', 0 do let(:player) { nil } end
    it_behaves_like 'score calculator', 0 do let(:player) { made_up_player } end
    it_behaves_like 'score calculator', 4 do let(:player) { game.players[0] } end
    it_behaves_like 'score calculator', 5 do let(:player) { game.players[1] } end
  end
end
