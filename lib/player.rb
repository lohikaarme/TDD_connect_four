# frozen_string_literal: true

class Player
  attr_accessor :p1, :p2, :current_turn

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
end
