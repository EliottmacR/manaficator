
displayed_wave = ""

DISPLAY_WAVE_TIME = 2

function init_hud()

  shop_w = {
  }
  
  shop_w.w = GW * 3/4
  shop_w.h = GH * 2/3
  
  shop_w.x = GW/2 - shop_w.w/2
  shop_w.y = GH/2 - shop_w.h/2
  
end

function update_hud()

  if SHOWING_MENU() then
  
    if SHOWING_SHOP then 
      
      local x = shop_w.x
      local y = shop_w.y
      local w = shop_w.w
      local h = shop_w.h
      
      if (btnr("select") and point_in_rect(btnv("mouse_x"), btnv("mouse_y"), x + w + 8, y - 20, 16, 16)) or btnr("back") then
        SHOWING_SHOP = false
      end
      
    end
  end
  
end

function draw_hud()

  if time_began_display_wave and time_began_display_wave > t() - DISPLAY_WAVE_TIME then 
    local str = "Wave " .. (displayed_wave or 1)
    use_font("32")
    c_cool_print(str, GW/2, GH/3 + 4*cos(t()))
  end
  
  if SHOWING_MENU() then
  
    if SHOWING_SHOP then 
    
      local x = shop_w.x
      local y = shop_w.y
      local w = shop_w.w
      local h = shop_w.h
      
      rct(x, y, w, h, _p_n("white"))
      for i = 1, 4 do
        rct(x + i, y + i, w - i*2, h - i*2, _p_n("black"))
      end
      rct(x + 5, y + 5, w - 10, h - 10, _p_n("white"))
      
      rctf(x + w + 8, y - 20, 16, 16, _p_n("red"))
      
    end
    
  end
  
end

function begin_display_wave(current_wave)
  displayed_wave = current_wave
  time_began_display_wave = t()
end









