# frozen_string_literal: true

require_relative '../lib/player'

describe Player do
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
