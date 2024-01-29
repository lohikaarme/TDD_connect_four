# frozen_string_literal: true

require_relative 'board'
require_relative 'player'

class Game
  attr_accessor :game_board, :players, :current_turn, :move, :winner, :game

  def initialize(game_board = Board.new)
    @game_board = game_board
    @players = { p1: Player.new(1, '🟡'), p2: Player.new(2, '🔵') }
    @current_turn = @players[:p1]
    @game = true
    @winner = nil
  end

  def game_loop
    @game_board.print_board
    @game_board.update_board(@current_turn, player_input)
    @winner = @game_board.won?(@game_board)
    turn_change
    continue?
  end

  def turn_change
    @current_turn = @current_turn == @players[:p1] ? @players[:p2] : @players[:p1]
  end

  def continue?
    i = true
    while i
      puts 'Continue?: Enter(Yes) | Escape(No)'
      begin
        answer = Kernel.gets.match(/\n|\e/).to_s
      rescue StandardError
        puts "\n-------------------------------"
        puts '| Erroneous input, try again! |'
        puts '-------------------------------'
      else
        i = false
      end
    end
    answer == "\n" ? return : @game = false
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
end
