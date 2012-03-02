require_relative 'hitpoint'
class Ship
	attr_accessor :collision, :kind
  def initialize(lake_hitpoint, bullet, score, map)
    @bullet = bullet
    @lake_hitpoint = lake_hitpoint
    @score = score
    @x = 185
    @y = 600
    @map = map
    @image = Image.load("images/ship.png")
    @image.setColorKey([0, 0, 0])   # add(opt ionaly)
    @collision = CollisionBox.new(self, 0, 0, @image.width, @image.height)
    super
  end

# ‘D‚Ì“®‚«
  def move_right
    if @x < 370
      @x += 5
    else
      @map.move_right
    end
  end
  
  def move_left
    if @x > 0
      @x -= 5
    else
        @map.move_left
    end
  end
   
# ‘D‚Ì•`‰æ
  def draw
    #Window.drawScale(0,670,@image_hide)
    Window.drawScale(@x,@y,@image,0.8,0.8)
     #   ª  ‰¡,c‚Ìk¬/Šg‘å 
   	@collision.set(@x, @y)  
  end

	def hit(obj)
		obj.deleted = 1
		if obj.kind =~ /steel\z/ or obj.kind == :god_shizimi
      if @bullet.bullet_max < 5
			  @bullet.bullet_max += 1
        @bullet.zansu_gauge += 1
      end
      if @bullet.zansu_gauge_array.size < 5
        if obj.kind == :redsteel
          @bullet.zansu_gauge_array.unshift("redsteel")
        elsif obj.kind == :bluesteel
          @bullet.zansu_gauge_array.unshift("bluesteel")
        elsif obj.kind == :yellowsteel
          @bullet.zansu_gauge_array.unshift("yellowsteel")
        elsif obj.kind == :god_shizimi
          @bullet.zansu_gauge_array.unshift("god_shizimi")
        end
      end
    elsif obj.kind == :shizimi
        @lake_hitpoint.damage = 10
        @lake_hitpoint.hp_minus
        @lake_hitpoint.damage = 50
    else
      if obj.kind == :akikan
        @score.score_plus(10)
      elsif obj.kind == :petbottle
        @score.score_plus(20)
      elsif obj.kind == :gomibukuro
        @score.score_plus(30)
      elsif obj.kind == :umbrella
        @score.score_plus(40)
      elsif obj.kind == :kutsu
        @score.score_plus(50)
      end
    end
	end
  
	def shot(obj)
	end
end
