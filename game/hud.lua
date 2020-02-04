
displayed_wave = ""

DISPLAY_WAVE_TIME = 2

function init_hud()
  
  init_menus()
  
end

function update_hud()
  
  update_menus()
  
  -- log_quest_status()
  
-- function show_qb()
-- function close_qb()

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
  
  draw_menus()
  
  
  
  
  -- add_log("player life : " .. player.life)
  
  
end

function begin_display_wave(current_wave)
  displayed_wave = current_wave
  time_began_display_wave = t()
end



-------------------


cursor_c = 1
timer_cursor = .1

function draw_cursor()

  spritesheet_grid (32, 32)
  timer_cursor = timer_cursor - dt()
  
  if timer_cursor < 0 then
    timer_cursor = .1
    cursor_c = random_c()
  end
  
  a_outlined(3, player.x + player.w/2, player.y + player.h/2, get_look_angle_player() + .5*3/4, 1, 1, .5, .5, _p_n("black"), {{_p_n("pink"), cursor_c}}) 
  
  pal ( )
  spritesheet_grid (16, 16)

end




