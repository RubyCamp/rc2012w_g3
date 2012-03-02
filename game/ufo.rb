class Ufo
	attr_accessor :x ,:counter, :collision

	def initialize(enemy_hitpoint, score)
    @enemy_hitpoint = enemy_hitpoint
		@x = rand(450)
		@y = 15
		@buf = 0
    @score = score
		@image_ufo = Image.load("images/ufo.png")
		@collision = CollisionBox.new(self,0,0,@image_ufo.width, @image_ufo.height)
		@counter = 0
    @game_sound = GameSound.new
	end


	def draw
		if @buf > 30
			@x = rand(450)
			@buf  = 0
		end
		Window.draw(@x, @y, @image_ufo)
		@collision.set(@x, @y)
		@buf += 1
	end
  
	def hit(obj)
    @score.score_plus(25)
    obj.deleted = 1
    if obj.what_obj.intern == :redsteel
      @enemy_hitpoint.damage = 30
      @enemy_hitpoint.hp_minus
      @enemy_hitpoint.damage = 15
      @game_sound.ufo.play
    elsif obj.what_obj.intern == :bluesteel
      @enemy_hitpoint.damage = 10
      @enemy_hitpoint.hp_minus
      @enemy_hitpoint.damage = 15
      @game_sound.ufo.play
    elsif obj.what_obj.intern == :yellowsteel
      @enemy_hitpoint.damage = 20
      @enemy_hitpoint.hp_minus
      @enemy_hitpoint.damage = 15
      @game_sound.ufo.play
    elsif obj.what_obj.intern == :god_shizimi
      @enemy_hitpoint.damage = 40
      @enemy_hitpoint.hp_minus
      @enemy_hitpoint.damage = 15
      @game_sound.ufo.play
    end
	  obj.collision = nil
	end
  
	def shot(obj)
	end
end


