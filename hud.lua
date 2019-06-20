
-- GW = 304
-- GH = 380

local hud = { surface          = nil,
              x                = 0,
              y                = 0,
              background_clr   = 2
            }
           
function init_hud()

  hud.surface = new_surface( GW - 20, GH/4 - 15)
  hud.x = 10
  hud.y = 10

end

function update_hud()

end

function draw_hud()

  target(hud.surface)
    local hud_w, hud_h = target_size()
    
    local border_w = 20
    local border_h = 20
    
    rectfill(0, 0, hud_w, hud_h, _colors.dark_red)
    rectfill(border_w, border_h, hud_w - border_w, hud_h - border_h, _colors.black)
    
    -- draw_bonuses()  
  target()  
    
  spr_sheet(hud.surface, hud.x, hud.y + sin_b * 3)
  
end

function draw_bonuses()

  use_font("log")
    
  local ct = 0
  local h = (str_px_height("9"))
  
  for ind, b in pairs(bonus_points) do
    color(_colors.white)
    
    local x = 30
    local y = 15 + h * ct
    
    print(level_txt[ind], x , y )  
    
    for i = 0, (b-1) do
      local w =  10
      local x_spc = 5
      local h = 10
      
      local xx = x + str_px_width(level_txt[ind]) + (w+x_spc) * i
      local yy = y + 10
      
      rectfill( xx,  yy,  xx + w , yy + h, _colors.light_pink)  
    end    
    ct = ct + 1
  end

end


  