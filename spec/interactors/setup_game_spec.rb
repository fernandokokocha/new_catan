# frozen_string_literal: true

describe SetupGame do
  let(:game) { Game.new }
  let(:player_1) { { name: 'Bartek', color: :orange } }
  let(:player_2) { { name: 'Leo', color: :blue } }
  let(:players) { [player_1, player_2] }
  let(:interactor) { SetupGame.new(players: players) }

  subject(:call) { game.handle(interactor) }

  context 'valid data' do
    it_behaves_like 'mutating interaction'

    it 'returns success' do
      expect(call.success?).to be(true)
    end

    it 'sets up game' do
      call
      expect(game.setup?).to be(true)
    end

    it 'sets up players' do
      call
      expect(game.players.length).to be(2)
      expect(game.players[0]).to eq(Player.new(name: 'Bartek', color: :orange))
      expect(game.players[1]).to eq(Player.new(name: 'Leo', color: :blue))
    end
  end

  context 'invalid color of player' do
    let(:player_1) { { name: 'Bartek', color: :green } }

    it_behaves_like 'not mutating interaction'

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq('Invalid player color: green of player Bartek')
    end
  end

  context 'invalid name of player' do
    let(:player_1) { { name: '', color: :orange } }

    it_behaves_like 'not mutating interaction'

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq('Players include empty name')
    end
  end

  context 'duplicated player names' do
    let(:player_2) { { name: player_1[:name], color: :blue } }

    it_behaves_like 'not mutating interaction'

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq('Player names include duplication: Bartek')
    end
  end

  context 'duplicated player colors' do
    let(:player_2) { { name: 'Leo', color: player_1[:color] } }

    it_behaves_like 'not mutating interaction'

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq('Player colors include duplication: orange')
    end
  end

  context 'too few players' do
    let(:players) { [player_1] }

    it_behaves_like 'not mutating interaction'

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq('Too few players: 1 instead of required at least 2')
    end
  end

  # context 'too many players' do
  #   let(:players) do
  #     [
  #       player_1,
  #       player_2,
  #       Player.new(name: 'Carles', color: :orange),
  #       Player.new(name: 'Gerard', color: :orange),
  #       Player.new(name: 'Andres', color: :orange)
  #     ]
  #   end
  # end

  context 'invoked second time' do
    before(:each) { game.handle(interactor) }

    it_behaves_like 'not mutating interaction'

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq('Game already initialized')
    end
  end
end
