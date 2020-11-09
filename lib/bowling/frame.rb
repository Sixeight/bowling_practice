module Bowling
  class Frame
    def initialize(max_count: 2)
      @pins      = []
      @count     = 0
      @max_count = max_count
    end

    def hit(pin)
      raise 'Frame is over' if over?
      raise 'There is only 10 pins' unless (0..10).include?(pin)

      @pins << pin
      @count += 1
    end

    def first_pin_count
      @pins[0] || 0
    end

    def second_pin_count
      @pins[1] || 0
    end

    def total_pin_count
      @pins.sum
    end

    def over?
      total_pin_count >= 10 || @count >= @max_count
    end

    def strike?
      first_pin_count >= 10
    end

    def spare?
      first_pin_count < 10 && total_pin_count >= 10
    end
  end
end
