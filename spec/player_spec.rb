# frozen_string_literal: true

require_relative '../lib/player'

describe Player do
  subject(:players) { described_class.new }

  describe '#initialize' do
    context 'players are created' do
      it 'creates player one with 🟡 symbol' do
        player1 = players.p1
        expect(player1[:player]).to eq(1)
        expect(player1[:sym]).to eq('🟡')
      end

      it 'creates player two is with 🔵 symbol' do
        player2 = players.p2
        expect(player2[:player]).to eq(2)
        expect(player2[:sym]).to eq('🔵')
      end

      it 'sets the current player to p1' do
        player = players.current_turn
        expect(player).to eq(players.p1)
      end
    end
  end

  describe '#end_turn' do
    context 'a player\'s turn ends' do
      it 'updates the current turn' do
        expect { players.end_turn }.to change { players.current_turn }.from(players.p1).to(players.p2)
        expect { players.end_turn }.to change { players.current_turn }.from(players.p2).to(players.p1)
      end
    end
  end
end
