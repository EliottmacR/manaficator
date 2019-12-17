
require("game/wands/_wands")

function init_player()
  player = {
    w = 16,
    h = 16,
    
    v = {
      x = 0,
      y = 0},  
      
    max_speed = 3.6,
    dash_time = .3,
    dash_speed = 14,
    
    buffs = {
      movement_speed = 1,
      firing_speed = 1,
      projectile_speed = 1,
    },
    
    wand_id = "lazershot",
    
  }
  player.x = world.x + (world.w-player.w)/2
  player.y = world.y + (world.h-player.h)/2
  
  
  player.inventory = {
    "winged_boots",
    "winged_crown",
    "speed_pills",
  }
  
  player.shot = t()

  -- init player's inventory items effects
  for i, id in pairs(player.inventory) do
    if items[id] and items[id].effect then items[id].effect() end
  end
  
  

  
end

function get_player_mov_angle()
  return atan2(player.v.x, player.v.y)
end
function get_look_angle_player()
  return atan2(cam.x + btnv("mouse_x") - (player.x + player.w/2) ,cam.y + btnv("mouse_y") - (player.y + player.h/2) )
end

function get_look_angle(e)
  if e == player then return get_look_angle_player() end

  -- return atan2(player.v.x, player.v.y)
end

function get_player_max_speed()
  return (player.dash_began and (player.dash_speed - (player.dash_speed - player.max_speed) * (t() - player.dash_began) / player.dash_time) 
          or player.max_speed) * player.buffs.movement_speed 
end

function update_player()

  local p = player
  
  local acceleration = 800 * dt()
  
  if btn("up") then 
    p.v.y = p.v.y - acceleration * dt()
  end                                  
                                       
  if btn("right") then                 
    p.v.x = p.v.x + acceleration * dt()
  end                                  
                                       
  if btn("down") then                  
    p.v.y = p.v.y + acceleration * dt()
  end                                  
                                       
  if btn("left") then                  
    p.v.x = p.v.x - acceleration * dt()
  end
  
  if btnp("space") then
    if not p.dash_began then
      p.dash_began = t()
    end 
  end
  
  if btn("shoot") then 
    if can_shoot(player) then 
      p.shot = t() 
      shoot(p) 
    end 
  end
  
  -- wand_update()
  
  if p.dash_began then 
  
    local angle = get_player_mov_angle()
    
    if p.dash_began + p.dash_time  < t() then 
      p.dash_began = nil
      
      p.v.x = cos(angle) * p.max_speed
      p.v.y = sin(angle) * p.max_speed
    else
    
      local norm_time_d = (t() - p.dash_began) / p.dash_time
      
      p.v.x = cos(angle) * (p.dash_speed - (p.dash_speed - p.max_speed) * norm_time_d)
      p.v.y = sin(angle) * (p.dash_speed - (p.dash_speed - p.max_speed) * norm_time_d)
   
      p.x = p.x + p.v.x * p.buffs.movement_speed 
      p.y = p.y + p.v.y * p.buffs.movement_speed 
    end
   
  else
    -- cap speed
    speed = dist(p.v.x, p.v.y)  
    local mspd = p.max_speed 
    
    if speed > mspd then
      p.v.x = p.v.x / speed * (mspd)
      p.v.y = p.v.y / speed * (mspd)
    end
    
    p.x = p.x + p.v.x * p.buffs.movement_speed 
    p.y = p.y + p.v.y * p.buffs.movement_speed 
    
    p.v.x = p.v.x * (1 - dt() * 6)
    p.v.y = p.v.y * (1 - dt() * 6)
  
  end
  
  --world boundaries
    p.x = mid(world.x, p.x, world.x + world.w - p.w)
    p.y = mid(world.y, p.y, world.y + world.h - p.h)
  --
  
end

function draw_player()

  rctf(player.x, player.y, player.w, player.h, _p_n("yellow"))
  
  local a = get_look_angle_player()
  
  -- line(player.x + player.w/2, player.y + player.h/2, player.x + player.w/2 + cos(a) * 32, player.y + player.h/2 + sin(a) * 32, _p_n("yellow"))

end




