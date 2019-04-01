# frozen_string_literal: true

describe SetupGame do
  let(:game) { Game.new }
  let(:player_params_1) { { name: 'Bartek', color: :orange } }
  let(:player_params_2) { { name: 'Leo', color: :blue } }
  let(:players_params) { [player_params_1, player_params_2] }
  let(:interactor) { SetupGame.new(players_params: players_params) }

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
      expect(game.players).to eq(
        [
          Player.new(name: 'Bartek', color: :orange),
          Player.new(name: 'Leo', color: :blue)
        ]
      )
    end
  end

  context 'valid data - 4 players' do
    let(:players_params) do
      [
        player_params_1,
        player_params_2,
        { name: 'Carles', color: :white },
        { name: 'Gerard', color: :red }
      ]
    end

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
      expect(game.players).to eq(
        [
          Player.new(name: 'Bartek', color: :orange),
          Player.new(name: 'Leo', color: :blue),
          Player.new(name: 'Carles', color: :white),
          Player.new(name: 'Gerard', color: :red)
        ]
      )
    end
  end

  context 'invalid color of player' do
    before(:each) { player_params_1[:color] = :green }

    it_behaves_like 'not mutating interaction'

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq('Invalid player color: green of player Bartek')
    end
  end

  context 'invalid name of player' do
    before(:each) { player_params_1[:name] = '' }

    it_behaves_like 'not mutating interaction'

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq('Players include empty name')
    end
  end

  context 'duplicated player names' do
    before(:each) { player_params_2[:name] = player_params_1[:name] }

    it_behaves_like 'not mutating interaction'

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq('Player names include duplication: Bartek')
    end
  end

  context 'duplicated player colors' do
    let(:player_params_2) { { name: 'Leo', color: player_params_1[:color] } }

    it_behaves_like 'not mutating interaction'

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq('Player colors include duplication: orange')
    end
  end

  context 'too few players' do
    let(:players_params) { [player_params_1] }

    it_behaves_like 'not mutating interaction'

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq('Too few players: 1 instead of required at least 2')
    end
  end

  context 'too many players' do
    let(:players_params) do
      [
        player_params_1,
        player_params_2,
        { name: 'Carles', color: :white },
        { name: 'Gerard', color: :red },
        { name: 'Andres', color: :orange }
      ]
    end

    it_behaves_like 'not mutating interaction'

    it 'returns failure' do
      expect(call.success?).to be(false)
    end

    it 'returns descriptive message' do
      expect(call.message).to eq('Too many players: 5 instead of required at most 4')
    end
  end

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
