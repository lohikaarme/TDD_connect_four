# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  describe '#initialize' do
    subject(:game_board) { described_class.new }
    context 'a game board is initialized' do
      it 'creates a 6x7 array' do
        board = game_board.game_board
        expect(board.length).to eq(6)
        expect(board.all? { |sub_arr| sub_arr.length == 7 }).to eq(true)
      end
    end
  end

  describe '#print_board' do
    subject(:game_board) { described_class.new }
    context 'renders a game board' do
      it 'prints out an empty game board' do
        expect do
          game_board.print_board
        end.to output("\n      1    2    3    4    5    6    7\n    ------------------------------------\n    | ⚫ | ⚫ | ⚫ | ⚫ | ⚫ | ⚫ | ⚫ |\n    ------------------------------------\n    | ⚫ | ⚫ | ⚫ | ⚫ | ⚫ | ⚫ | ⚫ |\n    ------------------------------------\n    | ⚫ | ⚫ | ⚫ | ⚫ | ⚫ | ⚫ | ⚫ |\n    ------------------------------------\n    | ⚫ | ⚫ | ⚫ | ⚫ | ⚫ | ⚫ | ⚫ |\n    ------------------------------------\n    | ⚫ | ⚫ | ⚫ | ⚫ | ⚫ | ⚫ | ⚫ |\n    ------------------------------------\n    | ⚫ | ⚫ | ⚫ | ⚫ | ⚫ | ⚫ | ⚫ |\n    ------------------------------------\n").to_stdout
      end
    end
  end

  # rubocop:disable Metrics/LineLength
  # rubocop:disable Layout/FirstArrayElementIndentation

  describe '#update_board' do
    let(:p1) { { player: 1, sym: '🟡' } }
    let(:p2) { { player: 2, sym: '🔵' } }
    subject(:changing_board) { described_class.new }
    context 'a player adds a piece to a column' do
      it 'updates cell [5,0] with p1' do
        expect { changing_board.update_board(p1, 1) }.to change { changing_board.instance_variable_get(:@game_board)[5][0] }.from(nil).to(p1)
      end
      it 'updates cell [4,0] with p2' do
        expect { changing_board.update_board(p1, 1) }.to change { changing_board.instance_variable_get(:@game_board)[5][0] }.from(nil).to(p1)
        expect { changing_board.update_board(p2, 1) }.to change { changing_board.instance_variable_get(:@game_board)[4][0] }.from(nil).to(p2)
      end
      it 'updates cell [3,0] with p1' do
        expect { changing_board.update_board(p1, 1) }.to change { changing_board.instance_variable_get(:@game_board)[5][0] }.from(nil).to(p1)
        expect { changing_board.update_board(p2, 1) }.to change { changing_board.instance_variable_get(:@game_board)[4][0] }.from(nil).to(p2)
        expect { changing_board.update_board(p1, 1) }.to change { changing_board.instance_variable_get(:@game_board)[3][0] }.from(nil).to(p1)
      end
      it 'updates cell [2,0] with p2' do
        expect { changing_board.update_board(p1, 1) }.to change { changing_board.instance_variable_get(:@game_board)[5][0] }.from(nil).to(p1)
        expect { changing_board.update_board(p2, 1) }.to change { changing_board.instance_variable_get(:@game_board)[4][0] }.from(nil).to(p2)
        expect { changing_board.update_board(p1, 1) }.to change { changing_board.instance_variable_get(:@game_board)[3][0] }.from(nil).to(p1)
        expect { changing_board.update_board(p2, 1) }.to change { changing_board.instance_variable_get(:@game_board)[2][0] }.from(nil).to(p2)
      end
      it 'updates cell [1,0] with p1' do
        expect { changing_board.update_board(p1, 1) }.to change { changing_board.instance_variable_get(:@game_board)[5][0] }.from(nil).to(p1)
        expect { changing_board.update_board(p2, 1) }.to change { changing_board.instance_variable_get(:@game_board)[4][0] }.from(nil).to(p2)
        expect { changing_board.update_board(p1, 1) }.to change { changing_board.instance_variable_get(:@game_board)[3][0] }.from(nil).to(p1)
        expect { changing_board.update_board(p2, 1) }.to change { changing_board.instance_variable_get(:@game_board)[2][0] }.from(nil).to(p2)
        expect { changing_board.update_board(p1, 1) }.to change { changing_board.instance_variable_get(:@game_board)[1][0] }.from(nil).to(p1)
      end
      it 'updates cell [0,0] with p2' do
        expect { changing_board.update_board(p1, 1) }.to change { changing_board.instance_variable_get(:@game_board)[5][0] }.from(nil).to(p1)
        expect { changing_board.update_board(p2, 1) }.to change { changing_board.instance_variable_get(:@game_board)[4][0] }.from(nil).to(p2)
        expect { changing_board.update_board(p1, 1) }.to change { changing_board.instance_variable_get(:@game_board)[3][0] }.from(nil).to(p1)
        expect { changing_board.update_board(p2, 1) }.to change { changing_board.instance_variable_get(:@game_board)[2][0] }.from(nil).to(p2)
        expect { changing_board.update_board(p1, 1) }.to change { changing_board.instance_variable_get(:@game_board)[1][0] }.from(nil).to(p1)
        expect { changing_board.update_board(p2, 1) }.to change { changing_board.instance_variable_get(:@game_board)[0][0] }.from(nil).to(p2)
      end
      it 'does not update game board when given cell [-1,0] with p1' do
        expect { changing_board.update_board(p1, 1) }.to change { changing_board.instance_variable_get(:@game_board)[5][0] }.from(nil).to(p1)
        expect { changing_board.update_board(p2, 1) }.to change { changing_board.instance_variable_get(:@game_board)[4][0] }.from(nil).to(p2)
        expect { changing_board.update_board(p1, 1) }.to change { changing_board.instance_variable_get(:@game_board)[3][0] }.from(nil).to(p1)
        expect { changing_board.update_board(p2, 1) }.to change { changing_board.instance_variable_get(:@game_board)[2][0] }.from(nil).to(p2)
        expect { changing_board.update_board(p1, 1) }.to change { changing_board.instance_variable_get(:@game_board)[1][0] }.from(nil).to(p1)
        expect { changing_board.update_board(p2, 1) }.to change { changing_board.instance_variable_get(:@game_board)[0][0] }.from(nil).to(p2)
        expect { changing_board.update_board(p1, 1) }.not_to(change { changing_board.instance_variable_get(:@game_board) })
      end
    end
  end

  describe '#win_check' do
    let(:p1) { { player: 1, sym: '🟡' } }
    let(:p2) { { player: 2, sym: '🔵' } }
    context 'a player has a winning position' do
      subject(:winning_board) { described_class.new }
      it 'returns a win state on a horizontal alignment' do
        winning_board.instance_variable_set(:@game_board, [
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, p1, p1, p1, p1, nil, nil]
        ])
        expect(winning_board.won?).to eq(p1)
      end
      it 'returns a win state on a vertical alignment' do
        winning_board.instance_variable_set(:@game_board, [
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, p1, nil, nil, nil, nil, nil],
          [nil, p1, nil, nil, nil, nil, nil],
          [nil, p1, nil, nil, nil, nil, nil],
          [nil, p1, nil, nil, nil, nil, nil]
        ])
        expect(winning_board.won?).to eq(p1)
      end
      it 'returns a win state on a diagonal alignment' do
        winning_board.instance_variable_set(:@game_board, [
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, p1, nil, nil],
          [nil, nil, nil, p1, nil, nil, nil],
          [nil, nil, p1, nil, nil, nil, nil],
          [nil, p1, nil, nil, nil, nil, nil]
        ])
        expect(winning_board.won?).to eq(p1)
      end
    end

    context 'no player has a winning position' do
      subject(:losing_board) { described_class.new }
      it 'returns a nil state on a horizontal alignment' do
        losing_board.instance_variable_set(:@game_board, [
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [p1, nil, p1, p1, p1, nil, nil]
        ])
        expect(losing_board.won?).to eq(nil)
      end
      it 'returns a nil state on a horizontal alignment wrapping edge case' do
        losing_board.instance_variable_set(:@game_board, [
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [p1, nil, nil, nil, p1, p1, p1]
        ])
        expect(losing_board.won?).to eq(nil)
      end

      it 'returns a nil state on a vertical alignment' do
        losing_board.instance_variable_set(:@game_board, [
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, p1, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, p1, nil, nil, nil, nil, nil],
          [nil, p1, nil, nil, nil, nil, nil],
          [nil, p1, nil, nil, nil, nil, nil]
        ])
        expect(losing_board.won?).to eq(nil)
      end
      it 'returns a nil state on a vertical alignment wrapping edge case' do
        losing_board.instance_variable_set(:@game_board, [
          [nil, p1, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, p1, nil, nil, nil, nil, nil],
          [nil, p1, nil, nil, nil, nil, nil],
          [nil, p1, nil, nil, nil, nil, nil]
        ])
        expect(losing_board.won?).to eq(nil)
      end
      it 'returns a nil state on a diagonal alignment' do
        losing_board.instance_variable_set(:@game_board, [
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, p1, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, p1, nil, nil, nil],
          [nil, nil, p1, nil, nil, nil, nil],
          [nil, p1, nil, nil, nil, nil, nil]
        ])
        expect(losing_board.won?).to eq(nil)
      end
      it 'returns a nil state on a diagonal alignment wrapping edge case' do
        losing_board.instance_variable_set(:@game_board, [
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, p1, nil, nil, nil],
          [nil, nil, p1, nil, nil, nil, nil],
          [nil, p1, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, p1]
        ])
        expect(losing_board.won?).to eq(nil)
      end
    end
  end
  # rubocop:enable Metrics/LineLength
  # rubocop:enable Layout/FirstArrayElementIndentation
end
