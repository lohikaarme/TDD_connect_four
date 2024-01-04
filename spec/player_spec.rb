# frozen_string_literal: true

require_relative '../lib/player'

describe Player do
  describe '#initialize' do
    subject(:players_init) { described_class.new }
    context 'players are created' do
      it 'creates player one with 🟡 symbol' do
        player1 = players_init.p1
        expect(player1[:player]).to eq(1)
        expect(player1[:sym]).to eq('🟡')
      end

      it 'creates player two is with 🔵 symbol' do
        player2 = players_init.p2
        expect(player2[:player]).to eq(2)
        expect(player2[:sym]).to eq('🔵')
      end

      it 'sets the current player to p1' do
        player = players_init.current_turn
        expect(player).to eq(players_init.p1)
      end
    end
  end

  describe '#end_turn' do
    subject(:players_end) { described_class.new }
    context 'a player\'s turn ends' do
      it 'updates the current turn' do
        expect { players_end.end_turn }.to change { players_end.current_turn }.from(players_end.p1).to(players_end.p2)
        expect { players_end.end_turn }.to change { players_end.current_turn }.from(players_end.p2).to(players_end.p1)
      end
    end
  end

  describe '#player_move' do
    subject(:players) { described_class.new }
    before { allow($stdout).to receive(:puts) }

    context 'when user enters an input' do
      it 'receives a legal value' do
        expect(Kernel).to receive(:gets).and_return('1')
        expect { players.player_move }.to change { players.move }.from(nil).to(1)
      end

      it 'raises an error on an illegal value' do
        expect(Kernel).to receive(:gets).and_raise('StandardError').once
        expect(Kernel).to receive(:gets).and_return('1')
        expect { players.player_move }.to output(/Erroneous input, try again!/).to_stdout
      end
    end
  end
end
