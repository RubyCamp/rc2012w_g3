
class Bullet
  attr_accessor :canon_flg, :collision, :deleted, :bullet_max, :zansu_gauge, :what_obj, :zansu_gauge_array
  def initialize
    @bullet_image = {"redsteel" => Image.load("./images/redsteel.png"), "redsteel_mini" => Image.load("./images/redsteel1.png"),
                     "bluesteel" => Image.load("./images/bluesteel.png"), "bluesteel_mini" => Image.load("./images/bluesteel1.png"),
                     "yellowsteel" => Image.load("./images/yellowsteel.png"), "yellowsteel_mini" => Image.load("./images/yellowsteel1.png"),
                     "god_shizimi" => Image.load("./images/god_shizimi.png"), "god_shizimi_mini" => Image.load("./images/god_shizimi1.png")}
    @canon_bullet_pos = [[570, 490, 0, 5],   #キャノンｘ，キャノンｙ、玉ｘ、玉ｙ
                         [550, 490, 0.8, 4],
                         [530, 497, 1.5, 4],
                         [515, 505, 2.2, 4],
                         [502, 515, 2.9, 4],
                         [488, 530, 3.6, 4],
                         [478, 540, 8.0, 4],
                         [468, 557, 8,   4]]

    @canon_bullet_zansu_pos = [[603.5, 231.5],
                               [603.5, 184.5],
                               [603.5, 137.5],
                               [603.5, 90.5],
                               [603.5, 43.5]]
    @zansu_gauge_array = []
    5.times do
      @zansu_gauge_array << "bluesteel"
    end
    @gauge_frame = Image.load("./images/life.png")
    @canon_flg = false
	  @deleted = 0
    @bullet_max = 5
    @zansu_gauge = @bullet_max
    @mini_draw_key = "redsteel_mini"

  end
  
  def canon_draw(pos_num, obj)
    @what_obj = obj
    if @bullet_max > 0	
      if @canon_flg == false
        @zansu_gauge_array.pop
        @x, @y, @a, @b = @canon_bullet_pos[pos_num][0], @canon_bullet_pos[pos_num][1], @canon_bullet_pos[pos_num][2], @canon_bullet_pos[pos_num][3]
	      @collision = CollisionBox.new(self, 0, 0, @bullet_image[obj].width, @bullet_image[obj].height) 
        Window.draw(@x, @y, @bullet_image[obj])
        @canon_flg = true
	      @collision.set(@x, @y)
        @zansu_gauge -= 1 if @bullet_max >= 1
	      @deleted = 0
	    elsif @canon_flg == true
        @x -= @a
        @y -= @b
        @collision = CollisionBox.new(self, 0, 0, @bullet_image[obj].width, @bullet_image[obj].height) 
        Window.draw(@x, @y, @bullet_image[obj])
	      @collision.set(@x, @y)
      end
    end
    if @deleted == 1 or  @x < -20 or @y < -20
	    @deleted = 0
      @canon_flg = false
      @bullet_max -= 1 if @bullet_max >= 1
    end
  end

  def zansu
    Window.draw(590, 30, @gauge_frame)
    @zansu_gauge_array.size.times do |i|
        Window.draw(@canon_bullet_zansu_pos[i][0], @canon_bullet_zansu_pos[i][1], @bullet_image[@zansu_gauge_array[i] + "_mini"])
    end
  end 
  
	def hit(obj)
	end

	def shot(obj)
	end
  
end

