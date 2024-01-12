# frozen_string_literal: true

require_relative 'board'
require_relative 'player'

class Game
  attr_accessor :game_board, :players, :current_turn, :move

  def initialize (game_board = Board.new)
    @game_board = game_board
    @players = { p1: Player.new(1, '🟡'), p2: Player.new(2, '🔵') }
    @current_turn = @players[:p1]
  end

  def game_loop
    @game_board.print_board
    @game_board.update_board(@current_turn, self.player_input)
    @game_board.won?(@game_board)
  end

  def end_turn
    if @current_turn == @players[:p1]
      @current_turn = @players[:p2]
    else
      @current_turn = @players[:p1]
    end
  end

  def player_input
    i = true
    while i
      puts "Player #{@current_turn}, it is your turn, place your piece (1-7):"
      begin
        @move = Kernel.gets.match(/[1-7]/)[0].to_i
      rescue StandardError
        puts "\n-------------------------------"
        puts '| Erroneous input, try again! |'
        puts '-------------------------------'
      else
        i = false
      end
    end
    @move
  end

  1+1
end
