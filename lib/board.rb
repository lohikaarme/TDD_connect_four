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

  def won?(game_board = @game_board)
    [method(:horizontal_win), method(:vertical_win), method(:diagonal_win)].detect do |winning_func|
      result = winning_func.call(game_board)
      break result if result
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

  def array_won?(array)
    current_el = nil
    count = 0
    array.each do |el|
      if el == current_el
        count += 1
      else
        current_el = el
        count = 1
      end
      return current_el if count == 4
    end
    nil
  end

  def horizontal_win(game_board = @game_board)
    winner = nil
    game_board.each do |row|
      if winner = array_won?(row)
        break
      end
    end
    winner
  end

  def vertical_win(game = @game_board)
    winner = nil
    game_board.transpose.each do |row|
      if winner = array_won?(row)
        break
      end
    end
    winner
  end

  def diagonal_win(game = @game_board)
    rows = game_board.count
    columns = game_board[0].count
    new_arr_count = rows + columns - 1
    trans_arr = Array.new(new_arr_count) {[]}

    game_board.each_with_index do |row, r_idx|
      row.each_with_index do |el, c_idx|
        arr_idx = r_idx + c_idx
        trans_arr[arr_idx] << el
      end
    end

    winner = nil
    trans_arr.each do |row|
      if winner = array_won?(row)
        break
      end
    end
    winner
  end
end
