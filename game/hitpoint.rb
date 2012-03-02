class Hitpoint
  attr_accessor :damage, :end_check_flg, :hp_max, :height
  def initialize(height, x_pos, y_pos, damage, frame_num) 
    @frame_num = frame_num
    @height, @hp_max = height, height
    @hp_base = Image.new(20, @height, [255, 0, 0])    
    @hp_gauge_frame = [Image.load("./images/hp.png"), Image.load("./images/e_hp.png")]
    @y = y_pos + @height #@y = 530
    @x = x_pos
    @damage = damage
    @game_sound = GameSound.new
    @end_check_flg = true
  end
  
  def draw
    Window.draw(@x - 10, 30, @hp_gauge_frame[@frame_num])
    if @height > 0
      if @frame_num == 0
        @hp = Image.new(30, @height, [0, 0, 255])
      else @frame_num == 1
        @hp = Image.new(30, @height, [255, 0, 0])
      end
      Window.drawRot(@x + 25, @y + 6, @hp, 180, 0, 0)#630
    end
  end
  
  def hp_plus
    @height += 10
    @game_sound.shijimi.play # ‰ñ•œ‰¹
    if @height > @hp_max
      @height = @hp_max
    end
  end
  
  def hp_minus
    @height -= @damage
    if @height <= 0
      return false
    end
  end 
  
  def hp_check
    if @height <= 0
      @end_check_flg = false
    end
  end
end
