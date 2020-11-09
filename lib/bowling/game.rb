require_relative 'frame'

module Bowling
  class Game
    def initialize
      @frames = []
      @frames << Frame.new
    end

    def hit(pin)
      frame = @frames.last
      frame.hit(pin)

      next_frame!(frame) if frame.over?
    end

    def frame_count
      [frame_size, 10].min
    end

    def score
      @frames.take(10).sum do |frame|
        if frame.strike?
          strike_score_for(frame)
        elsif frame.spare?
          spare_score_for(frame)
        else
          score_for(frame)
        end
      end
    end

    private

    def frame_at(index, offset: 0)
      @frames[index + offset]
    end

    def frame_index_for(frame)
      @frames.find_index(frame)
    end

    def frame_size
      @frames.size
    end

    def strike_score_for(frame)
      index = frame_index_for(frame)
      next_frame = frame_at(index, offset: 1)

      first_pin_count, second_pin_count =
        if next_frame.strike?
          [next_frame.total_pin_count, frame_at(index, offset: 2).first_pin_count]
        else
          [next_frame.first_pin_count, next_frame.second_pin_count]
        end

      frame.total_pin_count + first_pin_count + second_pin_count
    end

    def spare_score_for(frame)
      index = frame_index_for(frame)
      next_pin_count = frame_at(index, offset: 1).first_pin_count
      frame.total_pin_count + next_pin_count
    end

    def score_for(frame)
      frame.total_pin_count
    end

    def next_frame!(current)
      if frame_size == 11
        @frames << Frame.new(max_count: 1) if current.strike?
      elsif frame_size == 10
        @frames << Frame.new(max_count: 2) if current.strike?
        @frames << Frame.new(max_count: 1) if current.spare?
      else
        @frames << Frame.new(max_count: 2)
      end
    end
  end
end
