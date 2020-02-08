
displayed_wave = ""

DISPLAY_WAVE_TIME = 2

function init_hud()
  
  init_menus()
  
  init_hp_bar()
end

function update_hud()
  
  timer_cursor = timer_cursor - dt()
  
  if timer_cursor < 0 then
    timer_cursor = .1
    cursor_c = random_c()
  end
  
  update_menus()
  update_hp_bar()
  

  if btnp("quest") then 
    if SHOWING_QB then
      close_qb()
    else
      show_qb()
    end
  end
end

function draw_hud()

  if time_began_display_wave and time_began_display_wave > t() - DISPLAY_WAVE_TIME then 
    local str = "Wave " .. (displayed_wave or 1)
    use_font("32")
    c_cool_print(str, GW/2, GH/3 + 4*cos(t()))
  end
  
  if mouse_msg then
    use_font("16")
    c_cool_print(mouse_msg, btnv("mouse_x"), btnv("mouse_y") + 12 + 4*cos(t()) )
    mouse_msg = nil
  end
  
  draw_hp_bar() 
  
  draw_menus()
  
  
  
  
  -- add_log("player life : " .. player.life)
  
  
end

function begin_display_wave(current_wave)
  displayed_wave = current_wave
  time_began_display_wave = t()
end



-------------------

function init_hp_bar()
  hp_bar = {}
  
  hp_bar.x = 4
  hp_bar.y = 4
  
  hp_bar.x_scale = 1
  hp_bar.y_scale = 1
  
  hp_bar.s = 28 * 8
  
  hp_bar.life = player.life
  hp_bar.max_life = player.max_life
  
end

function update_hp_bar()

  if hp_bar.life < player.life then
    hp_bar.life = min(player.life, hp_bar.life + dt())
  elseif hp_bar.life > player.life then
    hp_bar.life = max(player.life, hp_bar.life - dt())
  end
  
  if hp_bar.max_life < player.max_life then
    hp_bar.max_life = min(player.max_life, hp_bar.max_life + dt())
  elseif hp_bar.max_life > player.max_life then
    hp_bar.max_life = max(player.max_life, hp_bar.max_life - dt())
  end
  
end

function draw_hp_bar()
  
  local pl  = hp_bar.life
  local pml = hp_bar.max_life
  
  local rat = pl / pml
  
  local width = 16 + 16 + 16 * (pml / 5) - 4 - 4
  rctf(hp_bar.x + 4, hp_bar.y + 3, width, 32 - 4 - 4 - 1, _p_n("black"))
  rctf(hp_bar.x + 4, hp_bar.y + 3, width * rat, 32 - 4 - 4 - 1, _p_n("ppink"))
  
  use_font("16")
  local str = flr(pl / pml * 100)
    
  c_cool_print(str, hp_bar.x + 16 + 8 * (pml / 5), hp_bar.y + 16 - 2, _p_n("green"), _p_n("black"))
  
  aspr(hp_bar.s, hp_bar.x, hp_bar.y, 0, 1, 2, 0, 0, hp_bar.scale_x, hp_bar.scale_y)
  aspr(hp_bar.s+1, hp_bar.x + 16, hp_bar.y, 0, 1, 2, 0, 0, pml / 5, hp_bar.scale_y)
  aspr(hp_bar.s+2, hp_bar.x + 16 + 16 * pml / 5, hp_bar.y, 0, 1, 2, 0, 0, hp_bar.scale_x, hp_bar.scale_y)
  
end


  
-------------------


cursor_c = 1
timer_cursor = .1

function draw_cursor()

  spritesheet_grid (32, 32)
  a_outlined(3, player.x + player.w/2, player.y + player.h/2, get_look_angle_player() + .5*3/4, 1, 1, .5, .5, _p_n("black"), {{_p_n("pink"), cursor_c}}) 
  
  pal ( )
  spritesheet_grid (16, 16)

end




