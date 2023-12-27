# frozen_string_literal: true

class Board
  attr_accessor :game_board

  def initialize
    @game_board = Array.new(6) { Array.new(7) }
  end

  def print_board(game_board = @game_board)
    puts "\n      1    2    3    4    5    6    7\n    ------------------------------------\n"
    game_board.each_with_index do |row, r_idx|
      row_arr = ['    |']
      row.each_with_index do |_col, c_idx|
        row_arr << " #{cell(game_board, r_idx, c_idx)} |"
      end
      puts row_arr.join
      puts "    ------------------------------------\n"
    end
  end

  def update_board(player, position, game_board = @game_board)
    column = position - 1
    row = valid_row(column)
    if row
      game_board[row][column] = player
    end
  end

  private

  def cell(game_board, row, column)
    cell = game_board[row][column]
    if cell.nil?
      '⚫'
    else
      cell[:sym]
    end
  end

  def valid_row(column, game_board = @game_board)
    valid_row = false
    i = 5
    until valid_row || i < 0
      valid_row = i if game_board[i][(column)].nil?
      i -= 1
    end
    valid_row
  end
end
