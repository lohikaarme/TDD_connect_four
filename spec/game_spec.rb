# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  let(:mock_player) { instance_double('Player') }
  let(:mock_board) { instance_double('Board') }

  before do
    allow(Player).to receive(:new).with(1, '🟡').and_return(:p1)
    allow(Player).to receive(:new).with(2, '🔵').and_return(:p2)
  end

  describe '#end_turn' do
    subject(:players_end) { described_class.new }
    context 'a player\'s turn ends' do
      it 'updates the current turn' do
        expect { players_end.end_turn }.to change { players_end.current_turn }.from(:p1).to(:p2)
        expect { players_end.end_turn }.to change { players_end.current_turn }.from(:p2).to(:p1)
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
      allow(mock_board).to receive(:won?)
     end

    context 'a player performs their turn' do
      it 'prints the board' do
        expect(mock_board).to receive(:print_board)
        turn_game.game_loop
      end

      it 'gets the player input' do
        expect(turn_game).to receive(:player_input)
        turn_game.game_loop
      end

      it 'calls updated_board on the game board' do
        expect(mock_board).to receive(:update_board).with(:p1, '1')
        turn_game.game_loop
      end

      it 'checks for a winner' do
        allow(mock_board).to receive(:update_board).with(:p1, '1')
        expect(mock_board).to receive(:won?)
        turn_game.game_loop
      end

      xit 'ends the turn'
    end
  end
end
