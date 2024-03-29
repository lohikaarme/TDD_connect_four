# frozen_string_literal: true

require_relative 'board'
require_relative 'player'

class Game
  attr_accessor :game_board, :players, :current_turn, :move, :winner, :game, :game_end

  def initialize(game_board = Board.new)
    @game_board = game_board
    @players = { p1: Player.new(1, '🟡'), p2: Player.new(2, '🔵') }
    @current_turn = @players[:p1]
    @game = true
    @winner = nil
  end

  # Main repeating game loop
  def game_loop
    @game_board.print_board
    @game_board.update_board(@current_turn, player_input)
    @winner = @game_board.won?
    turn_change
    continue?
    game_end
  end

  # Changes the current player turn based on current state
  def turn_change
    @current_turn = @current_turn == @players[:p1] ? @players[:p2] : @players[:p1]
  end

  # Checks if the user wants to continue or end game
  def continue?
    answer = nil
    loop do
      puts 'Continue?: Enter(Yes) | Escape(No)'
      begin
        answer = Kernel.gets.match(/\n|\e/).to_s
        break
      rescue StandardError
        puts "\n-------------------------------"
        puts '| Erroneous input, try again! |'
        puts '-------------------------------'
      end
    end
    answer == "\n" ? return : @game = false
  end

  # Gets user choice for game piece placement
  def player_input
    loop do
      puts "Player #{@current_turn.player}, it is your turn, place your piece (1-7):"
      begin
        @move = Kernel.gets.match(/[1-7]/)[0].to_i
        @game_board.legal_move?(@move) ? break : raise
      rescue StandardError
        puts "\n-------------------------------"
        puts '| Erroneous input, try again! |'
        puts '-------------------------------'
      end
    end
    @move
  end

  def game_end
    return unless @winner

    @game = false
    @game_board.print_board
    puts "Player #{@winner.player} wins!"
  end

  private

  def play_game
    game_loop while @game
  end
end
