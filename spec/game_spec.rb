# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  let(:mock_player) { instance_double('Player') }
  let(:mock_board) { instance_double('Board') }

  before do
    allow(Player).to receive(:new).with(1, '🟡').and_return(:p1)
    allow(Player).to receive(:new).with(2, '🔵').and_return(:p2)
  end

  describe '#turn_change' do
    subject(:player_change) { described_class.new }
    before { allow($stdout).to receive(:puts) }

    context 'a player\'s turn ends' do
      it 'updates the current turn' do
        expect { player_change.turn_change }.to change { player_change.current_turn }.from(:p1).to(:p2)
        expect { player_change.turn_change }.to change { player_change.current_turn }.from(:p2).to(:p1)
      end
    end
  end

  describe '#continue?' do
    subject(:continue_game) { described_class.new }
    before { allow($stdout).to receive(:puts) }

    context 'a player is asked to keep playing' do
      it 'receives the Enter key' do
        expect(Kernel).to receive(:gets).and_return("\n")
        expect { continue_game.continue? }.not_to(change { continue_game.game })
      end

      it 'receives the Esc key' do
        expect(Kernel).to receive(:gets).and_return("\e")
        expect { continue_game.continue? }.to change { continue_game.game }.to eq(false)
      end

      it 'raises an error on an illegal value' do
        expect(Kernel).to receive(:gets).and_raise('StandardError').once
        expect(Kernel).to receive(:gets).and_return("\n")
        expect { continue_game.continue? }.to output(/Erroneous input, try again!/).to_stdout
      end
    end
  end

  describe '#player_input' do
    subject(:turn_input) { described_class.new }
    before { allow($stdout).to receive(:puts) }

    context 'when user enters an input' do
      it 'receives a legal value' do
        expect(Kernel).to receive(:gets).and_return('1')
        expect { turn_input.player_input }.to change { turn_input.move }.from(nil).to(1)
      end

      it 'raises an error on an illegal value' do
        expect(Kernel).to receive(:gets).and_raise('StandardError').once
        expect(Kernel).to receive(:gets).and_return('1')
        expect { turn_input.player_input }.to output(/Erroneous input, try again!/).to_stdout
      end
    end
  end

  describe '#game_loop' do
    subject(:turn_game) { described_class.new(mock_board) }
    before do
      allow($stdout).to receive(:puts)
      allow(Player).to receive(:new).with(1, '🟡').and_return(:p1)
      allow(Player).to receive(:new).with(2, '🔵').and_return(:p2)
      allow(turn_game).to receive(:player_input).and_return('1')
      allow(Board).to receive(:new).and_return(mock_board)
      allow(mock_board).to receive(:print_board)
      allow(mock_board).to receive(:update_board).and_return(true)
      allow(mock_board).to receive(:won?).and_return(:p1)
      allow(turn_game).to receive(:continue?)
    end

    context 'a player performs their turn' do
      it 'prints the board' do
        expect(mock_board).to receive(:print_board).twice
        # happens twice due to the win condition printing, likely need to split this up
        turn_game.game_loop
      end

      it 'gets the player input' do
        expect(turn_game).to receive(:player_input).once
        turn_game.game_loop
      end

      it 'calls updated_board on the game board' do
        expect(mock_board).to receive(:update_board).with(:p1, '1').once
        turn_game.game_loop
      end

      it 'checks for and updates winner' do
        allow(mock_board).to receive(:update_board).with(:p1, '1')
        expect(mock_board).to receive(:won?)
        turn_game.game_loop
        winner = turn_game.instance_variable_get(:@winner)
        expect(winner).to eq(:p1)
      end

      it 'changes the turn' do
        expect(turn_game).to receive(:turn_change).once
        turn_game.game_loop
      end

      it 'continues the game' do
        expect(turn_game).to receive(:continue?).once
        expect { turn_game.continue? }.not_to(change { turn_game.instance_variable_get(:@game) })
      end
    end
  end

  describe '#game_end' do
    subject(:game_end_test) { described_class.new }

    context 'when a player has won' do
      before do
        allow($stdout).to receive(:puts)
        game_end_test.instance_variable_set(:@winner, :p1)
      end

      it 'sets the game to false' do
        expect { game_end_test.game_end }.to change { game_end_test.instance_variable_get(:@game) }.from(true).to(false)
      end

      it 'prints the winner' do
        expect { game_end_test.game_end }.to output(/p1/).to_stdout
      end
    end

    context 'no one has won' do
      before do
        allow($stdout).to receive(:puts)
        game_end_test.instance_variable_set(:@winner, nil)
      end

      it 'does not set the game to false' do
        expect { game_end_test.game_end }.not_to change { game_end_test.instance_variable_get(:@game) }
      end

      it 'does not print a winner' do
        expect { game_end_test.game_end }.not_to output(/p1/).to_stdout
        end
      end
    end
  end
