
class Map
  def initialize
    @background = Image.load("./images/background.png")
    @x, @y = -680, 0
  end
  
  def draw
    Window.draw(@x, @y, @background)
  end
  
  def get(ufoshoted)
    @ufoshoted = ufoshoted
  end
  
  def move_right
    if @x >= -660
      @x -= 5
      @ufoshoted.right_tyousei
    end
  end
  
  def move_left
    if @x < 0
      @x += 5
      @ufoshoted.left_tyousei
    end
    
  end
end
