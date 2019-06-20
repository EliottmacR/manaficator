
--- bonuses


b_text = {
  "Magic Spd+",
  "Magic Size+",
  "Magic Range+",
  "Fire Rate+"
}

bonus_points = { -- see b_text for more info
  0,
  0,
  0,
  0 
}

bonuses = {
  b_speed_mult = 1,
  b_range_mult = 1,
  b_size_mult = 1,
  fire_rate_mult = 1,
  damage = 0
}

level_txt = {
  "M-SPD",
  "M-RNG",
  "M-RAD",
  "F-RTE" 
}

sk_tree = {
  -- { [branch][level] : is_activated 
  {0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0}
  -- {1, 1, 1, 1, 1, 0},
  -- {1, 1, 1, 1, 1, 0},
  -- {1, 1, 0, 0, 0, 0}
}
sk_tree_txt = {
  -- { [branch][level] : is_activated 
  {"Fire Aspect",        "Speed T-1",     "Damage T-1", "Fire Rate T-2", "Speed T-2", "Rebound"},
  {"Electro Aspect",     "Size T-1",      "Auto-Aim",   "Double",        "Size T-2",  "Shotgun"},
  {"Range T-1",          "Fire Rate T-1", "Dash"      , "Fire Rate T-2", "Range T-2", "Explosions"}
}
sk_tree_func = {
  {fire,         speed_p, damage,   firer_p,      speed_p, rebounds},
  {electricity , size_p,  auto_a,   more_bullets, size_p,  shotgun},
  {range_p,      firer_p, dash_,    firer_p,      range_p, explosion}
}

function init_sk_tree()

  sk_tree = {
    -- { [branch][level] : is_activated 
    {0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0}
    -- {1, 1, 1, 1, 1, 0},
    -- {1, 1, 1, 1, 1, 0},
    -- {1, 1, 0, 0, 0, 0}
  }
  sk_tree_txt = {
    -- { [branch][level] : is_activated 
    {"Fire Aspect",        "Speed T-1",     "Damage T-1", "Fire Rate T-2", "Speed T-2", "Rebound"},
    {"Electro Aspect",     "Size T-1",      "Auto-Aim",   "Double",        "Size T-2",  "Shotgun"},
    {"Range T-1",          "Fire Rate T-1", "Dash"      , "Fire Rate T-2", "Range T-2", "Explosions"}
  }
  sk_tree_func = {
    {fire,         speed_p, dmg_p,   firer_p,      speed_p, rebounds},
    {electricity , size_p,  auto_a,   more_bullets, size_p,  shotgun},
    {range_p,      firer_p, dash_,    firer_p,      range_p, explosion}
  }
  
end

function speed_p() bonuses.b_speed_mult   = (bonuses.b_speed_mult   or 1) * 1.12 end
function size_p()  bonuses.b_size_mult    = (bonuses.b_size_mult    or 1) * 1.2 end
function range_p() bonuses.b_range_mult   = (bonuses.b_range_mult   or 1) * 1.2 end
function firer_p() bonuses.fire_rate_mult = (bonuses.fire_rate_mult or 1) * 1.2 end
function dmg_p()   bonuses.damage         =  bonuses.damage + 1 end

function fire()         add_skill(1)     end
function electricity()  add_skill(2)     end 

function auto_a()       add_skill(3)     end  -- auto aim 
function dash_()        add_skill(4) here()     end 
function more_bullets() 
  p.shoot_times = p.shoot_times + 1 
  fire_mods[p.fire_mod].fire_rate = fire_mods[p.fire_mod].fire_rate * 1.8
end

function rebounds()     add_skill(5) end
function shotgun()      p.shoot_times = p.shoot_times + 3 
                        p.dispersion = p.dispersion * 6  
                        p.b_speed_diff = .5
                        fire_mods[p.fire_mod].b_speed = fire_mods[p.fire_mod].b_speed / 2 
                        fire_mods[p.fire_mod].b_life = fire_mods[p.fire_mod].b_life * 3/4
                        fire_mods[p.fire_mod].fire_rate = fire_mods[p.fire_mod].fire_rate * 2.5
end
function explosion()    add_skill(6) end


function add_bonus(id)
  unlock_next_skill(tree_id)
end

function unlock_next_skill(tree_id)

  local i = 0  
  repeat
    sk_tree[tree_id][i] = true 
    i = i + 1
  until not sk_tree[tree_id][i+1]   
end

function update_skills(tree_id)
  -- bonus_points[id] = bonus_points[id] + 1
  -- update_bonuses()  
  -- next_skill(sk_tree[tree_id])
end