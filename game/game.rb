require_relative 'canon'
require_relative 'ship'
require_relative 'gamesound'
require_relative 'map'
require_relative 'player'
require_relative 'ufoshoted'
require_relative 'ufo'
require_relative 'score'
class Game
    attr_accessor :sound_win, :sound_lose, :outer1, :outer2, :bgm_play
  def initialize
    @canon = Canon.new
    @map = Map.new
    @bullet = Bullet.new
    @canon_bullet_flg = false
	  @ary = []
	  @collision = []
	  @ary_c =[]
    @score = Score.new
    @end_image = Image.load("./images/loser.png")
    @start_image= Image.load("./images/winner.png")
    @lake_hitpoint = Hitpoint.new(500, 650, 30, 50, 0)
    @enemy_hitpoint = Hitpoint.new(500, 10, 30, 25, 1)
	  @ufo = Ufo.new(@enemy_hitpoint, @score)
    @ship = Ship.new(@lake_hitpoint, @bullet, @score, @map)
	  @buf = 0
    @color_flg = false
    @game_sound = GameSound.new
    @bgm_start = 0 #
    @bgm_end = 0  
	  @sound_win = nil
	  @sound_lose  = nil
	  @outer1 = 0
	  @outer2 = 0
	@bgm_play = 0
  end
  
  def play         
    all_draw                                                                 #メインループ
    collision_c = []
    @lake_hitpoint.hp_check
    @enemy_hitpoint.hp_check
    if @lake_hitpoint.end_check_flg != false
    
    #砲台の弾の発射、描画------------------------------------------------------------------------------------/
    @canon.move_right(@canon_bullet_flg) if Input.keyPush?( K_RIGHT ) 
    @canon.move_left(@canon_bullet_flg) if Input.keyPush?( K_LEFT )          #キャノンの方向設定。
    
    if Input.keyPush?( K_SPACE ) and @canon_bullet_flg == false		#発射フラグ？
      @canon_bullet_flg = true 
      @color_flg = true
    end
    if @canon_bullet_flg == true 
      if @color_flg == true and @bullet.zansu_gauge_array.last != nil
        @color = @bullet.zansu_gauge_array.last#[@bullet.zansu_gauge_array.size - 1]
        @color_flg =false
        @game_sound.cannon.play # 発射音
      end
      @bullet.canon_draw(@canon.canon_angle / -10, @color)
      if @bullet.canon_flg == false   #bulletから、くる　終了条件ですね。
        @canon_bullet_flg = false
		  end
    end
    
    #船の移動--------------------------------------------------------------------------------------------------/
    @ship.move_right if Input.keyDown?( K_D ) 
    @ship.move_left if Input.keyDown?( K_A )

    #ufoの移動、弾の描画---------------------------------------------------------------------------------------/
	  if @buf > 40
      @taihi = Ufoshoted.new(@ufo.x, @lake_hitpoint, @map)
		  @ary  << @taihi  #スペースキーで、ゴミを追加
      @map.get(@taihi)
		  @buf = 0
	  end
    @buf += 1

    for x in 0..@ary.size        #玉の行列を、nilとかdeletedとか除いて綺麗に。
		  if (@ary[x] == nil || (@ary[x]).deleted == 1 )
			  @ary.delete_at(x)
		  end
	  end
	
    #コリジョンのチェック--------------------------------------------------------------------------------------/
  	@collisions = @ary.map{|i| i.collision }
	  @collisions << @ship.collision            #テストを追加
	  Collision.check(@collisions, @collisions)

	  if @bullet.collision != nil  and  @bullet.deleted == 0
		  collision_c << @bullet.collision
	  end
		collision_c << @ufo.collision
		 Collision.check(collision_c, collision_c) 
  end
  end
  def all_draw
    if @lake_hitpoint.end_check_flg == false
		@game_sound.bgm_play.stop if @bgm_play == 1
		@bgm_play = 0 if @bgm_play == 1   
      Window.draw(0, 0, @end_image)
	  @score.score_check
       if @bgm_start == 0
		     @sound_lose =@game_sound.bgm_end
		     @sound_lose.play
       end   
        @bgm_start = 1 if @bgm_start == 0 #
    elsif @enemy_hitpoint.end_check_flg == false
	@game_sound.bgm_play.stop if @bgm_play == 1 
		@bgm_play = 0 if @bgm_play == 1          
	  @score.score_check
      Window.draw(0, 0, @start_image)
	     if @bgm_start == 0   
   		   @sound_win  = @game_sound.bgm_win
	       @sound_win.play  #
       end
	       @bgm_start = 1 if @bgm_start == 0 #      
    else
	@game_sound.bgm_play.play if @bgm_play == 0  ####
		@bgm_play = 1 if @bgm_play == 0          #####
      @map.draw
      @bullet.zansu
      @ufo.draw
	    @ship.draw
      @ary.each do |s|
		    s.draw 
      @game_sound.bgm.stop  if @bgm_end == 0    #
      @bgm_end += 1 if @bgm_end == 0            #    
	    end
      @lake_hitpoint.draw
      @enemy_hitpoint.draw
      @canon.draw
      @score.draw

    end
  end
  @bgm_start += 1 if @bgm_start == 0 #  
  
  def new_game_check
    return @lake_hitpoint.end_check_flg, @enemy_hitpoint.end_check_flg
  end

end
