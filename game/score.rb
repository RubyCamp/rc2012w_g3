
class Score
  def initialize
    @best_score = File.read("score_data.txt").to_i
    @score = 0
    @font = Font.new(24)
    @best_score_frame = Image.load("./images/score.png")
  end
  
  def score_plus(num)
    @score += num
  end
  
  def draw
    Window.draw(0, 540, @best_score_frame)
    Window.drawFont(565, 630, "SCORE\n" + "      " + @score.to_s, @font, {:color => [255, 69, 0]})
    Window.drawFont(5, 540, "BEST!\n" + "  " + @best_score.to_s, @font, {:color => [0, 0, 51]})
  end
  
  def score_check
    if @best_score < @score
      @data_io = File.open("score_data.txt", "w+")
      @data_io.rewind
      p @best_score, @score
      @data_io.write(@score)
      @data_io.close
    end
  end
end
