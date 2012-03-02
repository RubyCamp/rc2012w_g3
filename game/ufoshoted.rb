require 'dxrubyex'

class Ufoshoted
	attr_accessor :collision, :x, :y, :deleted, :kind  #deletecd==1で、表示リストから削除　
	def initialize(x, hitpoint, map)
		@x = x + 30
		@y = 40
		@buf = 0
		@deleted = 0
    @lake_hitpoint = hitpoint
    @map = map
    @end_image = Image.load("./images/loser.png")
		number = rand(101)
    steel_number = rand(3)
    shizimi_number = rand(9)
    garbage_number = rand(15)
    if Input.keyPush?( K_TAB )
        p "a"
			  @image = Image.load("images/god_shizimi.png")
			  @kind = :god_shizimi
    end
    if (number % 10) == 0
      if steel_number == 0
			  @image = Image.load("images/redsteel1.png")
			  @kind = :redsteel
      elsif steel_number == 1
        @image = Image.load("images/bluesteel1.png")
			  @kind = :bluesteel
      elsif steel_number == 2
        @image = Image.load("images/yellowsteel1.png")
			  @kind = :yellowsteel
      end
		elsif (number % 5) == 0
      if shizimi_number == 5 
			  @image = Image.load("images/god_shizimi.png")
			  @kind = :god_shizimi
      else
        @image = Image.load("images/shizimi.png")
        @kind = :shizimi
      end
		else
      if garbage_number == 0 or garbage_number ==5 or garbage_number == 7 or garbage_number == 11 or garbage_number == 6
			  @image = Image.load("images/gav2.png")
			  @kind = :akikan
      elsif garbage_number == 1 or garbage_number == 8 or garbage_number == 12 or garbage_number == 14
        @image = Image.load("images/gav1.png")
			  @kind = :petbottle
      elsif garbage_number == 2 or garbage_number == 9 or garbage_number == 13
        @image = Image.load("images/gav5.png")
			  @kind = :gomibukuro
      elsif garbage_number == 3 or garbage_number == 10
        @image = Image.load("images/gav4.png")
			  @kind = :umbrella
      elsif garbage_number == 4
        @image = Image.load("images/gav3.png")
			  @kind = :kutsu
      end
		end
		@collision = CollisionBox.new(self, 0, 0, @image.width, @image.height) 
    @obj_flg = true
	end

	def draw
		if @buf > 15 and @obj_flg == true
			@y += 20
			@buf = 0
		end
    
    if @y < 660
		  Window.draw(@x, @y, @image)
	    @collision.set(@x, @y)
    else
      @obj_flg = false
      if self.kind == :akikan
        @lake_hitpoint.hp_minus
      elsif self.kind == :petbottle
        @lake_hitpoint.hp_minus
      elsif self.kind == :gomibukuro
        @lake_hitpoint.hp_minus
      elsif self.kind == :umbrella
        @lake_hitpoint.hp_minus
      elsif self.kind == :kutsu
        @lake_hitpoint.hp_minus
      elsif self.kind == :shizimi
        @lake_hitpoint.hp_plus
      elsif self.kind == :god_shizimi
        @lake_hitpoint.hp_minus
      end
      @deleted = 1
    end
		@buf += 1
	end
  
  def left_tyousei
    @x += 5
  end
  
  def right_tyousei
    @x -= 5
  end

	def hit(obj)
	end
  
	def shot(obj)
	end
end
     
