
-- GW = 304
-- GH = 380



local x_pool = 0
local y_pool = 0
w_pool = 0
h_pool = 0
b_pool = 0
local pool_s        = nil

local player = {}

show_lvl_up = false

local t_respawn = 0

function init_pool()
  
  x_pool = 10
  y_pool = GH * 1/4 + 5
  ww = GW - 20
  hh = GH * 3/4 - 15
  
  border_w = 32
  border_h = 32
  
  w_pool = ww
  h_pool = hh
  b_pool = 32
  
  
  pool_s = new_surface(ww, hh)
  
  init_skills()
  init_player(ww, hh) 
  init_fire_mods()
  init_enemy_types()
  init_waves()
  show_lvl_up = false

  
end

function update_pool(dt)
  if screen_shake_timer > 0 then 
    screen_shake_timer = screen_shake_timer - dt 
  else
    screen_shake_timer = 0
  end
  
  if btn(1) then 
    -- local i = 1 + irnd(4)
    -- bonus_points[i] = bonus_points[i] + 1   
    -- update_bonuses()  
  end
  
  update_waves(dt)  
  if show_lvl_up then update_lvl_up() end
  update_player(dt)
  update_enemies(dt)
  update_bullets(dt) 
  
end

function add_skill(id)
  if id == 1 and not p.skills[id] then
    p.skills[id] = true
  end
end


function draw_pool()

  target(pool_s)
  
  cls(background_clr)
  
  rectfill(0, 0, ww, hh, _colors.dark_red)
  rectfill(border_w, border_h, ww - border_w, hh - border_h, 10)
  
  if show_lvl_up then draw_lvl_up() end
  
  draw_player()
  draw_enemies()
  draw_bullets()
  
  target()
  
  spr_sheet(pool_s, x_pool + (irnd(30) - 15)  * screen_shake_timer, y_pool + (irnd(10) - 5) * screen_shake_timer)

  
end

screen_shake_timer = 0

function screen_shake()

  screen_shake_timer = min(screen_shake_timer + .3, .5 )

end

function rnd_pos_inside_pool(wsize, hsize)

  local x = ww - border_w * 2 - (wsize or 0)
  local y = hh - border_h * 2 - (hsize or 0)

  x = irnd(x) + border_w
  y = irnd(y) + border_h

  return x, y
end


--------- lvl up

-- sk_tree = {
  -- { [branch][level] : is_activated 
  -- {0, 0, 0, 0, 0, 0},
  -- {0, 0, 0, 0, 0, 0},
  -- {0, 0, 0, 0, 0, 0}
-- }

-- sk_tree_txt = {
  -- { [branch][level] : is_activated 
  -- {"Fire Aspect",        "Speed T-1",     "Damage T-1", "Fire Rate T-2", "Speed T-2", "Rebound"},
  -- {"Electricity Aspect", "Size T-1",      "Auto-Aim",   "Double",        "Size T-2",  "Shotgun"},
  -- {"Range T-1",          "Fire Rate T-1", "Dash"      , "Fire Rate T-2", "Range T-2", "Explosions"}
-- }

-- sk_tree_func = {
  -- {fire,         speed_p, damage,   firer_p,      speed_p, rebound},
  -- {electricity , size_p,  auto_aim, more_bullets, size_p,  shotgun},
  -- {range_p,      firer_p, dash,     firer_p,      range_p, explosion}
-- }

lvl_up = {}

function init_lvl_up()
  
  lvl_up = pick_levels()

end

function pick_levels()
  -- will give first locked skill on the 3 trees  
  local levels = {}  
  for tree_id = 1, 3 do   
    local i = 0  
    repeat
      i = i + 1
    until sk_tree[tree_id][i] == 0 or i > count(sk_tree[tree_id])
    log(tree_id .. ":" .. i)
    if i <= count(sk_tree[tree_id]) then
      levels[tree_id] = i        
    end
    
  end
  return levels
end

function pick_distinct_number( count, from, to) -- from and to are included
  if (to - from + 1) < count then log("oops") return end
  local numbers = {}
  
  for i = from, to do
    add(numbers, i)
  end
  
  return pick_distinct(count, numbers)

end
  
function update_lvl_up()
  local ct = count(lvl_up)    
  local ci = 0 
  for i, level in pairs(lvl_up) do
    ci = ci + 1
    local x = ww/2 + cos(ci/ct - 1/4) * ww/4 
    local y = hh/2 + sin(ci/ct - 1/4) * ww/4 + 30
    
    local xp = p.pos.x + p.w/2
    local yp = p.pos.y + p.h/2
    
    if dist(xp - x, yp - y) < p.w * 1.5 and btnp(9) then
      log("level ".. level .. " in tree " .. i .. " named " .. sk_tree_txt[i][level])
      time_leveled_up = time_leveled_up + 1
      sk_tree[i][level] = 1
      sk_tree_func[i][level]()
      condition_met = true
    end
  end
end

function draw_lvl_up()
  use_font("big")  
  local ct = count(lvl_up)  
  local ci = 0 
  for i, level in pairs(lvl_up) do
    ci = ci + 1
    local txt = sk_tree_txt[i][level] or ""
    
    local x = ww/2 + cos(ci/ct - 1/4) * ww/4 
    local y = hh/2 + sin(ci/ct - 1/4) * ww/4 + 30
    
    local xp = p.pos.x + p.w/2
    local yp = p.pos.y + p.h/2
    circfill(x, y, ww/20, _colors.black)
    if dist(xp - x, yp - y) < p.w * 1.5 then    
      circfill(x, y - 2 + sin_b, ww/20 - sin_b*6, _colors.light_purple)
      local str = "Press 'f' to level up"
      use_font("log")
      shaded_cool_print(str, xp - str_px_width(str)/2 , yp + str_px_height(str) + 4 + sin_b * 3, _colors.black)
        use_font("big")
      
    else
      circfill(x, y - 2 + sin_b, ww/20 - sin_b*6, _colors.light_pink )
    end
    color(_colors.black)
    shaded_cool_print(txt, x - str_px_width(txt)/2, y - str_px_height(txt)/2 - 60 + sin_b )
  
  end
end

function fact(x)
  if x == 0 then return 1 end
  return fact(x-1) * x
end
