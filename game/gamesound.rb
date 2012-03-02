class GameSound

# opening
 def bgm
   @sound =Sound.new("game_maoudamashii_7_event22.mid")
 end
 
# playing 
 def bgm_play
    @sound = Sound.new("pachanga.mid")
 end

# win 
 def bgm_win
  @sound =Sound.new("game_maoudamashii_3_theme14.mid")
 end

# lose
 def bgm_end
  @sound =Sound.new("game_maoudamashii_3_theme03.mid")
 end

# しじみゲット
def shijimi
 v = 150.0 # 音量
 c = 3000  # 分解能（音の長さ）
 f = 1760  # 周波数（音の高さ）
  @s1 = SoundEffect.new(800,WAVE_TRI,800) do
   c = c - 50
   if c < 0 then
     v = v - 2
     f = 1600
   end   
   [f, v]
  end
end


# 大砲発射
def cannon
 v = 100.0
 c = 60
 f = 1800
 @sound = SoundEffect.new(2000,WAVE_SIN) do
  c = c - 1
  if c < 0 then
    f = f - 1
    v = v - 0.1
  end
  [f, v]
 end
end



# UFO hit
 def ufo
  v = 100
  @sound = SoundEffect.new(4000,WAVE_RECT, 5000) do
    v = v - 0.03
    [rand(300), v]
  end
 end


end
