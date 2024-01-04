# frozen_string_literal: true

class Player
  attr_accessor :player, :sym

  def initialize(player, sym)
    @player = player
    @sym = sym
  end
end
