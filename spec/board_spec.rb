# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  subject(:game_board) { described_class.new }
  describe '#initialize' do
    context 'a game board is initialized' do
      it 'creates a 6x7 array' do
        board = game_board.game_board
        expect(board.length).to eq(6)
        expect(board.all? { |sub_arr| sub_arr.length == 7 }).to eq(true)
      end
    end
  end

  describe '#print_board' do
    context 'renders a game board' do
      it 'prints out an empty game board' do
        expect do
          game_board.print_board
        end.to output("\n      1    2    3    4    5    6    7\n    ------------------------------------\n    | ⚫ | ⚫ | ⚫ | ⚫ | ⚫ | ⚫ | ⚫ |\n    ------------------------------------\n    | ⚫ | ⚫ | ⚫ | ⚫ | ⚫ | ⚫ | ⚫ |\n    ------------------------------------\n    | ⚫ | ⚫ | ⚫ | ⚫ | ⚫ | ⚫ | ⚫ |\n    ------------------------------------\n    | ⚫ | ⚫ | ⚫ | ⚫ | ⚫ | ⚫ | ⚫ |\n    ------------------------------------\n    | ⚫ | ⚫ | ⚫ | ⚫ | ⚫ | ⚫ | ⚫ |\n    ------------------------------------\n    | ⚫ | ⚫ | ⚫ | ⚫ | ⚫ | ⚫ | ⚫ |\n    ------------------------------------\n").to_stdout
      end
    end
  end
end
