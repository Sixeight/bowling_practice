require_relative '../lib/fizz_buzz'

RSpec.describe FizzBuzz do
  let(:fizz_buzz) { FizzBuzz.new }

  describe '#convert(number)' do
    describe '3の倍数を入力するとFizzに変換されて出力される' do
      it '3を入力するとFizzが出力される' do
        expect(fizz_buzz.convert(3)).to eq('Fizz')
      end
    end

    describe '5の倍数を入力するとBuzzに変換されて出力される' do
      it '5を入力するとBuzzが出力される' do
        expect(fizz_buzz.convert(5)).to eq('Buzz')
      end
    end

    describe '3と5の倍数が入力されるとFizzBuzzに変換されて出力される' do
      it '15を入力するとFizzBuzzと出力される' do
        expect(fizz_buzz.convert(15)).to eq('FizzBuzz')
      end
    end

    describe 'それ以外が入力されるとそのまま文字列に変換されて出力される' do
      it '1を入力するとそのまま文字列に変換されて出力される' do
        expect(fizz_buzz.convert(1)).to eq('1')
      end
    end
  end
end
