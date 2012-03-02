require 'dxruby'
require_relative 'game'
require_relative 'gamesound'
@data_io = File.open("score_data.txt", "w+")
@data_io.write("0")
@data_io.close
Window.width  = 680
Window.height = 680
@game = Game.new
start_flg = false
start_image = Image.load("./images/start.png")
@game_sound = GameSound.new 
bgm_start = 0
bgm_end = 0
sound_buf = 0

Window.loop do
  if Input.keyPush?(K_ESCAPE)
    break
  end
  
  if Input.keyPush?(K_RETURN)
    start_flg = true
  end
  if @game.new_game_check[0] == false or @game.new_game_check[1] == false
    if Input.keyPush?(K_RETURN)
      if (@game.sound_win == nil)
		    @game.sound_lose.stop if @game.outer1 == 0
		    @game.outer1 = 1 if @game.outer1 == 0
	    else
		    @game.sound_win.stop if @game.outer2 == 0
		    @game.outer2 = 1 if @game.outer2 == 0
	    end
      @game = Game.new
    end
  end
 if start_flg == true
    @game_sound.bgm.stop  if bgm_end == 0    #
    bgm_end += 1 if bgm_end == 0             #
    @game.play
  elsif start_flg == false
    Window.draw(0, 0, start_image)    
    @game_sound.bgm.play if bgm_start == 0   #
  end
  bgm_start += 1 if bgm_start == 0 
end
