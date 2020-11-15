class Bowling
  def initialize
    @scores = []
  end

  def roll(pins)
    @scores << pins
  end

  def score
    round = 0
    @scores.each.with_index.sum do |score, i|
      if score == 10 # ストライク
        round = 0
        score + @scores[i + 1, 2].sum
      else
        round += 1
        if round == 2
          round = 0
          if score + @scores[i - 1] == 10 # スペア
            score + @scores[i + 1]
          else
            score
          end
        else
          score
        end
      end
    end
  end
end
