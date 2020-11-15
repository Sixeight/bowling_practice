require './lib/bowling'

RSpec.describe Bowling do
  describe '#score' do
    let(:game) { Bowling.new }
    subject { game.score }

    describe '全てガーターの場合' do
      before { 20.times { game.roll(0) } }
      it { is_expected.to eq 0 }
    end

    describe '全て１ピン倒した場合' do
      before { 20.times { game.roll(1) } }
      it { is_expected.to eq 20 }
    end

    describe '全てストライクだった場合' do
      before { 11.times { game.roll(10) } }
      it { is_expected.to eq 300 }
    end

    describe '全て５ピンずつ倒した場合 (スペア)' do
      before { 21.times { game.roll(5) } }
      it { is_expected.to eq 155 }
    end

    describe 'ストライクの次にスペアだった場合' do
      before do
        game.roll(10)
        game.roll(2)
        game.roll(8)
        game.roll(5)
      end
      it { is_expected.to eq 40 }
    end
  end
end
