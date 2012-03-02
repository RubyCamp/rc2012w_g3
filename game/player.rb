require_relative 'bullet'

class Player
  def initialize
    @player = Image.load("./images/player.png")
    @x, @y = 320, 610
    @bullet = Bullet.new(@x, @y)
  end
  
  def draw
    Window.draw(@x, @y, @player)
  end
  
  def shot
    @bullet.set(@x, @y)
  end
end
