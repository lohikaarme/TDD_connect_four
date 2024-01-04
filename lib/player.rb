# frozen_string_literal: true

class Player
  attr_accessor :p1, :p2, :current_turn, :move

  def initialize
    @p1 = { player: 1, sym: '🟡' }
    @p2 = { player: 2, sym: '🔵' }
    @current_turn = @p1
  end

  def end_turn
    if @current_turn == @p1
      @current_turn = @p2
    else
      @current_turn = @p1
    end
  end

  def player_move
    i = true
    while i
      puts "Player #{@current_turn[:player]}, it is your turn, place your piece (1-7):"
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
