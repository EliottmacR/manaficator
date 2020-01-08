
displayed_wave = ""

DISPLAY_WAVE_TIME = 2

function init_hud()

end

function update_hud()

end

function draw_hud()

  if time_began_display_wave and time_began_display_wave > t() - DISPLAY_WAVE_TIME then 
    local str = "Wave " .. (displayed_wave or 1)
    use_font("32")
    c_cool_print(str, GW/2, GH/3 + 4*cos(t()))
  end
  
end

function begin_display_wave(current_wave)
  displayed_wave = current_wave
  time_began_display_wave = t()
end









