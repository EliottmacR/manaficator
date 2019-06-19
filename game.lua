
require("pool")
require("player")
require("bullet")
require("enemy")
require("waves")
require("hud")
require("bonuses")
require("skills")
-- GW = 304
-- GH = 380

-- color 11 and 12 look nice
-- color 7, 8, 9, 0 and 10 do not break your eyes

local background_clr = 4
time_since_launch = 0
sin_b = 0


function init_game()

  load_font("sugarcoat/TeapotPro.ttf", 64*3/4, "big", true)
  load_font("sugarcoat/TeapotPro.ttf", 64/2, "log", false)
  
  -- init_screens()
  
  register_btn(0, 0, input_id("mouse_button", "lb"))
  register_btn(1, 0, input_id("mouse_button", "rb"))
  register_btn(2, 0, input_id("mouse_position", "x"))
  register_btn(3, 0, input_id("mouse_position", "y"))
  
  register_btn(4, 0, input_id("keyboard", "z"))
  register_btn(5, 0, input_id("keyboard", "q"))
  register_btn(6, 0, input_id("keyboard", "s"))
  register_btn(7, 0, input_id("keyboard", "d"))
  register_btn(8, 0, input_id("keyboard", "p"))
  
  init_hud(dt)
  init_pool(dt)
  
  sk_tree_func = {
    {fire,         speed_p, damage,   firer_p,      speed_p, rebounds},
    {electricity , size_p,  auto_a,   more_bullets, size_p,  shotgun},
    {range_p,      firer_p, dash,     firer_p,      range_p, explosion}
  }
  
end
  

function update_game(dt)
  time_since_launch = time_since_launch + dt
  sin_b = sin(t() / 2)
  
  update_hud(dt)
  update_pool(dt)
  
end

function draw_game()
  cls(background_clr)
  draw_hud()
  draw_pool()
  
  -- draw_mouse()
  -- if btn(1) then 
    -- draw_palette()    
  -- end
end


-- function draw_mouse()
    
-- end
function draw_palette()
  for i = 0, 15 do 
    local x  = i * (30 + 5)
    local co = i        
    rectfill(x, 0, x + 30, 0 + 30, co)       
  end
end