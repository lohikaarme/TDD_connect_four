# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  let(:mock_player1) { instance_double('Player') }
  let(:mock_player2) { instance_double('Player') }
  let(:mock_board) { instance_double('Board') }

  before do
    allow(Player).to receive(:new).with(1, '🟡').and_return(:p1)
    allow(Player).to receive(:new).with(2, '🔵').and_return(:p2)
  end

  describe '#end_turn' do
    subject(:players_end) { described_class.new }
    context 'a player\'s turn ends' do
      it 'updates the current turn' do
        expect { players_end.end_turn }.to change { players_end.current_turn }.from(:p1).to(:p2)
        expect { players_end.end_turn }.to change { players_end.current_turn }.from(:p2).to(:p1)
      end
    end
  end

  describe '#player_input' do
    subject(:turn_input) { described_class.new }
    before { allow($stdout).to receive(:puts) }

    context 'when user enters an input' do
      it 'receives a legal value' do
        expect(Kernel).to receive(:gets).and_return('1')
        expect { turn_input.player_input }.to change { turn_input.move }.from(nil).to(1)
      end

      it 'raises an error on an illegal value' do
        expect(Kernel).to receive(:gets).and_raise('StandardError').once
        expect(Kernel).to receive(:gets).and_return('1')
        expect { turn_input.player_input }.to output(/Erroneous input, try again!/).to_stdout
      end
    end
  end

  describe '#turn' do
    let(:p1) { { player: 1, sym: '🟡' } }
    let(:p2) { { player: 2, sym: '🔵' } }
    subject(:turn_game) { described_class.new }

    context 'a player performs their turn' do
      xit 'updates based on the player input' do
      end

      xit 'switches to p2\'s turn' do
      end
    end
  end
end
