# frozen_string_literal: true

class Board
  attr_accessor :game_board

  def initialize
    @game_board = Array.new(6) { Array.new(7) }
  end

  # Prints the board to the console
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

  # Updates the board with legal player moves
  def update_board(player, position, game_board = @game_board)
    column = position - 1
    row = valid_row(column)
    return unless row

    game_board[row][column] = player
  end

  # Checks if a player has won and returns the winning object or nil
  def won?(game_board = @game_board)
    [method(:horizontal_win), method(:vertical_win), method(:diagonal_win)].detect do |winning_func|
      result = winning_func.call(game_board)
      break result if result
    end
  end

  private

  # Returns the player piece at a give row and column, or ⚫ if the cell is nil
  def cell(game_board, row, column)
    cell = game_board[row][column]
    if cell.nil?
      '⚫'
    else
      cell.sym
    end
  end

  # Checks if the column is empty, and returns the row index if it is
  def valid_row(column, game_board = @game_board)
    valid_row = false
    i = 5
    until valid_row || i.negative?
      valid_row = i if game_board[i][(column)].nil?
      i -= 1
    end
    valid_row
  end

  # Checks if an array contains 4 consecutive non-nil elements of the same type
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

  # Checks if a player has won horizontally, returns winner
  def horizontal_win(game_board = @game_board)
    winner = nil
    game_board.each do |row|
      break if (winner = array_won?(row))
    end
    winner
  end

  # Checks if a player has won vertically, returns winner
  def vertical_win(game_board = @game_board)
    winner = nil
    game_board.transpose.each do |row|
      break if (winner = array_won?(row))
    end
    winner
  end

  # Checks if a player has won diagonally, returns winner
  def diagonal_win(game_board = @game_board)
    rows = game_board.count
    columns = game_board[0].count

    # Calculate and initialize the total number of diagonal arrays needed
    diagonal_array_count = rows + columns - 1
    # initialized with `[]` so that `nil` can be added to arrays
    diagonal_array = Array.new(diagonal_array_count) { [] }

    # Transposes board into diagonal arrays
    game_board.each_with_index do |row, r_idx|
      row.each_with_index do |el, c_idx|
        # Calculate the index for the diagonal array
        array_idx = r_idx + c_idx
        diagonal_array[array_idx] << el
      end
    end

    winner = nil
    diagonal_array.each do |row|
      break if (winner = array_won?(row))
    end
    winner
  end
end
