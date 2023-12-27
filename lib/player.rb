# frozen_string_literal: true

class Player
  attr_accessor :p1, :p2

  def initialize
    @p1 = { player: 1, sym: '🟡' }
    @p2 = { player: 2, sym: '🔵' }
  end
end
