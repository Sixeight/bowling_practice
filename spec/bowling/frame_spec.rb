require './lib/bowling/frame'

RSpec.describe Bowling::Frame do
  describe '#hit' do
    let(:frame) { Bowling::Frame.new }
    it '1投目は投げられる' do
      expect { frame.hit(0) }.not_to raise_error
    end
    it '2投目も投げられる' do
      frame.hit(0)
      expect { frame.hit(0) }.not_to raise_error
    end
    it '3投目は投げられない' do
      2.times { frame.hit(0) }
      expect { frame.hit(0) }.to raise_error 'Frame is over'
    end
    it '1投目で10ピン倒した場合は投げられない' do
      frame.hit(10)
      expect { frame.hit(0) }.to raise_error 'Frame is over'
    end
    it '10ピン以上は倒せない' do
      expect { frame.hit(11) }.to raise_error 'There is only 10 pins'
    end
    it '負の数のピン以上は倒せない' do
      expect { frame.hit(-1) }.to raise_error 'There is only 10 pins'
    end
  end

  describe '#first_pin_count' do
    let(:frame) { Bowling::Frame.new }
    subject { frame.first_pin_count }
    context '投げる前' do
      it { is_expected.to eq 0 }
    end
    context '1回投げたとき' do
      before { frame.hit(pin) }
      context '0ピン倒したとき' do
        let(:pin) { 0 }
        it { is_expected.to eq pin }
      end
      context '1ピン倒したとき' do
        let(:pin) { 1 }
        it { is_expected.to eq pin }
      end
      context '10ピン倒したとき' do
        let(:pin) { 10 }
        it { is_expected.to eq pin }
      end
    end
    context '2回投げたとき' do
      before do
        frame.hit(pin)
        frame.hit(2)
      end
      context '0ピン倒したとき' do
        let(:pin) { 0 }
        it { is_expected.to eq pin }
      end
      context '1ピン倒したとき' do
        let(:pin) { 1 }
        it { is_expected.to eq pin }
      end
      context '8ピン倒したとき' do
        let(:pin) { 5 }
        it { is_expected.to eq pin }
      end
    end
  end

  describe '#first_pin_count' do
    let(:frame) { Bowling::Frame.new }
    subject { frame.second_pin_count }
    context '投げる前' do
      it { is_expected.to eq 0 }
    end
    context '1回投げたとき' do
      before { frame.hit(pin) }
      context '0ピン倒したとき' do
        let(:pin) { 0 }
        it { is_expected.to eq 0 }
      end
      context '1ピン倒したとき' do
        let(:pin) { 1 }
        it { is_expected.to eq 0 }
      end
      context '10ピン倒したとき' do
        let(:pin) { 10 }
        it { is_expected.to eq 0 }
      end
    end
    context '2回投げたとき' do
      before do
        frame.hit(2)
        frame.hit(pin)
      end
      context '0ピン倒したとき' do
        let(:pin) { 0 }
        it { is_expected.to eq pin }
      end
      context '1ピン倒したとき' do
        let(:pin) { 1 }
        it { is_expected.to eq pin }
      end
      context '8ピン倒したとき' do
        let(:pin) { 5 }
        it { is_expected.to eq pin }
      end
    end
  end

  describe '#total_pin_count' do
    let(:frame) { Bowling::Frame.new }
    context '投げる前' do
      it { expect(frame.total_pin_count).to eq 0 }
    end
    context '1回投げた場合' do
      before { frame.hit(pin) }
      context '0ピン倒したとき' do
        let(:pin) { 0 }
        it { expect(frame.total_pin_count).to eq pin }
      end
      context '1ピン倒したとき' do
        let(:pin) { 1 }
        it { expect(frame.total_pin_count).to eq pin }
      end
      context '6ピン倒したとき' do
        let(:pin) { 6 }
        it { expect(frame.total_pin_count).to eq pin }
      end
      context '10ピン倒したとき' do
        let(:pin) { 10 }
        it { expect(frame.total_pin_count).to eq pin }
      end
    end
    context '2回投げた場合' do
      context 'どちらもガーターの場合' do
        before do
          frame.hit(0)
          frame.hit(0)
        end
        it { expect(frame.total_pin_count).to eq 0 }
      end
      context 'どちら数ピン倒したとき' do
        before do
          frame.hit(1)
          frame.hit(5)
        end
        it { expect(frame.total_pin_count).to eq 6 }
      end
      context 'スペアのとき' do
        before do
          frame.hit(2)
          frame.hit(8)
        end
        it { expect(frame.total_pin_count).to eq 10 }
      end
    end
  end

  describe '#over?' do
    subject { frame }
    context 'max_count=2のとき' do
      let(:frame) { Bowling::Frame.new }

      context '開始前' do
        it { is_expected.not_to be_over }
      end
      context '1投目を投げたあと' do
        before { frame.hit(0) }
        it { is_expected.not_to be_over }
      end
      context '2投目を投げたあと' do
        before { 2.times { frame.hit(0) } }
        it { is_expected.to be_over }
      end
      context '1投目で10ピン倒した場合' do
        before { frame.hit(10) }
        it { is_expected.to be_over }
      end
    end
    context 'max_count=1のとき' do
      let(:frame) { Bowling::Frame.new(max_count: 1) }

      context '開始前' do
        it { is_expected.not_to be_over }
      end
      context '1投目を投げたあと' do
        before { frame.hit(0) }
        it { is_expected.to be_over }
      end
    end
  end

  describe '#strike?' do
    let(:frame) { Bowling::Frame.new }
    subject { frame }
    context '開始前' do
      it { is_expected.not_to be_strike }
    end
    context '1投目で9ピン倒した場合' do
      before { frame.hit(9) }
      it { is_expected.not_to be_strike }
    end
    context '1投目で10ピン倒した場合' do
      before { frame.hit(10) }
      it { is_expected.to be_strike }
    end
  end

  describe '#spare?' do
    let(:frame) { Bowling::Frame.new }
    subject { frame }
    context '開始前' do
      it { is_expected.not_to be_spare }
    end
    context '1投目で9ピン倒した場合' do
      before { frame.hit(9) }
      it { is_expected.not_to be_spare }
    end
    context '1投目で10ピン倒した場合' do
      before { frame.hit(10) }
      it { is_expected.not_to be_spare }
    end
    context '2投合わせて9ピン倒した場合' do
      before do
        frame.hit(2)
        frame.hit(7)
      end
      it { is_expected.not_to be_spare }
    end
    context '2投合わせて10ピン倒した場合' do
      before do
        frame.hit(6)
        frame.hit(4)
      end
      it { is_expected.to be_spare }
    end
  end
end
