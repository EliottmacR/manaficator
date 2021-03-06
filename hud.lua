
-- GW = 700
-- GH = 900

local hud = { surface          = nil,
              back             = nil,
              x                = 0,
              y                = 0,
              background_clr   = 2
            }
           
function init_hud()
  hud.surface = new_surface( GW - 20, GH/4 - 15)
  hud.back = "hud_png"
  hud.x = 10
  hud.y = 10
  hud.w, hud.h = surface_size(hud.surface)
  starpos = {
              { {523, 143},         {529, 122},         {517, 104},         {529, 80},         {517, 61},         {523, 39}         },

              { {523+ 51, 143},     {529+ 51, 122},     {517+ 51, 104},     {529+ 51, 80},     {517+ 51, 61},     {523+ 51, 39}     },

              { {523+ 51+ 51, 143}, {529+ 51+ 51, 122}, {517+ 51+ 51, 104}, {529+ 51+ 51, 80}, {517+ 51+ 51, 61}, {523+ 51+ 51, 39} }
  }  
  PB = 0
end

function update_hud()

end

function draw_hud()

  target(hud.surface)
  
    spr_sheet(hud.back, 0, 0)
    
    -- stars
    for ind_tree, tree in pairs(starpos) do
      for ind_sk, star in pairs(tree) do
      
        if sk_tree[ind_tree][ind_sk] == 1 then        
          if ind_sk ~= 1 then
            line(star[1], star[2], starpos[ind_tree][ind_sk - 1][1], starpos[ind_tree][ind_sk - 1][2], _colors.sky_blue)
          end
          circfill(star[1], star[2], 6, _colors.plastic_blue)
          circfill(star[1], star[2], 4, _colors.dark_red)
        end
        
      end
    end
    
    -- life
    local x = (GW - 20) / 2 - 12 - 2 * (30 + 5)
    local y = 28    
    for i = 1, p.max_hp do 
        circfill((i-1) * (30 + 5) + x + 13, 15 + y + sin(time_since_launch / p.hp*3 + (i/p.max_hp)) * 6, 13,  _colors.light_red)        
        circfill((i-1) * (30 + 5) + x + 13, 15 + y + sin(time_since_launch / p.hp*3 + (i/p.max_hp)) * 6,  8, i > p.hp and _colors.black or _colors.white)
    end
    
    -- wave
    local wv = current_wave == 0 and 1 or (current_wave == (#waves + 1) and "inf" or current_wave)
    use_font("big")
    
    local str = "wave"
    cool_print(str, 100 - str_px_width(str) / 2, 15)
    shaded_cool_print(wv, 100 - str_px_width(wv) / 2, 50 ) -- + sin_b * 2)
    
    -- score
    local str = p.score
    shaded_cool_print(str, hud.w/2 - str_px_width(str) / 2 , hud.h * 3/4 - 5 )
    
    -- PB
    local str_PB = max(p.score, PB or 0)
    shaded_cool_print(str_PB, hud.w/4 - str_px_width(str_PB) / 2  - 68, hud.h * 3/4 - 10) -- + sin_b * 2 )
    
    local str = "P.Best"
    cool_print(str, hud.w/4 - str_px_width(str) / 2  - 68, hud.h * 3/4 - 50 )
    
    
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


  