require './lib/bowling/game'

RSpec.describe Bowling::Game do
  describe '#hit' do
    let(:game) { Bowling::Game.new }

    context ''
  end

  describe '#frame_count' do
    let(:game) { Bowling::Game.new }
    subject { game.frame_count }

    before { count.times { game.hit(0) }}

    context 'ゲーム開始前' do
      let(:count) { 0 }
      it { is_expected.to eq 1 }
    end

    context '1回投げたとき' do
      let(:count) { 1 }
      it { is_expected.to eq 1 }
    end

    context '2回投げたとき' do
      let(:count) { 2 }
      it { is_expected.to eq 2 }
    end

    context '17回投げたとき' do
      let(:count) { 17 }
      it { is_expected.to eq 9 }
    end

    context '20回投げたとき' do
      let(:count) { 20 }
      it { is_expected.to eq 10 }
    end
  end

  describe '#score' do
    let(:game) { Bowling::Game.new }
    subject { game.score }

    context 'ゲーム開始前' do
      it { is_expected.to eq 0 }
    end

    context '全てガーターの場合' do
      before do
        20.times { game.hit(0) }
      end
      it { is_expected.to eq 0 }
    end

    context '1本倒した場合' do
      before do
        game.hit(1)
        19.times { game.hit(0) }
      end
      it { is_expected.to eq 1 }
    end

    context '全ての回で1本倒した場合' do
      before do
        20.times { game.hit(1) }
      end
      it { is_expected.to eq 20 }
    end

    context 'いくつかピンを倒した場合' do
      before do
        game.hit(3)
        game.hit(5)
        18.times { game.hit(0) }
      end
      it { is_expected.to eq 8 }
    end

    context '1回ストライクを出したとき' do
      before { game.hit(10) }

      context 'そのあとガーターだった場合' do
        before do
          18.times { game.hit(0) }
        end
        it { is_expected.to eq 10 }
      end

      context 'そのあと何ピンか倒した場合' do
        before do
          game.hit(2)
          game.hit(6)
          16.times { game.hit(0) }
        end
        it { is_expected.to eq 26 }
      end

      context '次もストライクだった場合' do
        before do
          game.hit(10)
          game.hit(2)
          game.hit(0)
          14.times { game.hit(0) }
        end
        it { is_expected.to eq 36 }
      end

      context '３連続ストライクだった場合' do
        before do
          game.hit(10)
          game.hit(10)
          game.hit(5)
          game.hit(2)
          12.times { game.hit(0) }
        end
        it { is_expected.to eq 79 }
      end
    end

    context '1回スペアを出したとき' do
      before do
        game.hit(2)
        game.hit(8)
      end

      context 'そのあとガーターだった場合' do
        before do
          18.times { game.hit(0) }
        end
        it { is_expected.to eq 10 }
      end

      context '何ピンか倒した時' do
        before do
          game.hit(5)
          17.times { game.hit(0) }
        end
        it { is_expected.to eq 20 }
      end

      context 'またスペアだったとき' do
        before do
          game.hit(5)
          game.hit(5)
          game.hit(3)
          15.times { game.hit(0) }
        end
        it { is_expected.to eq 31 }
      end

      context 'そのあとストライクだったとき' do
        before do
          game.hit(10)
          game.hit(6)
          game.hit(1)
          14.times { game.hit(0) }
        end
        it { is_expected.to eq 44 }
      end
    end

    context '10フレーム目でいい成績を収めた場合' do
      before { 18.times { game.hit(0) } }
      context 'ストライクだった場合' do
        before { game.hit(10) }
        it 'もう2回投げられて得点が加算されること' do
          expect { game.hit(4) }.not_to raise_error
          expect { game.hit(3) }.not_to raise_error
          is_expected.to eq 17
        end
        it 'ストライクが続いてももう2回投げられて得点が加算されること' do
          expect { game.hit(10) }.not_to raise_error
          expect { game.hit(10) }.not_to raise_error
          is_expected.to eq 30
        end
      end
      context 'スペアだった場合' do
        before do
          game.hit(6)
          game.hit(4)
        end
        it 'もう1回投げられて得点が加算されること' do
          expect { game.hit(2) }.not_to raise_error
          is_expected.to eq 12
        end
      end
    end

    context 'パーフェクトゲームだった時' do
      before { 12.times { game.hit(10) } }
      it { is_expected.to eq 300 }
    end
  end
end
