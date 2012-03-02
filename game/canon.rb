require_relative 'bullet'

class Canon
  attr_accessor :canon_angle
  def initialize
    @image = Image.load("./images/canon.png")
    @image_target = Image.load("./images/targetmark.png")
    @image_target_pos = [[452, 0],
                         [350, 0],
                         [232, 0],
                         [136, 0],
                         [6, 0]]
    @x, @y = 550, 560
    @canon_angle = -10
  end
  
  def move_right(check)
    if @canon_angle < -10
      @canon_angle += 10
    end
  end
  
  def move_left(check)
    if @canon_angle > -50
      @canon_angle -= 10
    end
  end
    
  def draw
    Window.draw( @image_target_pos[@canon_angle / -10 - 1 ][0], @image_target_pos[@canon_angle / -10 - 1 ][1], @image_target)
    Window.drawRot( @x, @y, @image, @canon_angle )
  end
end
