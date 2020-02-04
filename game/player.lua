
require("game/wands/_wands")

function init_player()
  player = {
    w = 16,
    h = 16,
    
    v = {
      x = 0,
      y = 0},  
    
    ry = function() return player.y end,
    
    max_speed = 3.6,
    dash_time = .3,
    dash_speed = 14,
    
    life = 5,
    
    until_recovery = 0,
    recovery_time = 1,
    
    anim_t = 0,
    
    buffs = {
      movement_speed = 1,
      firing_speed = 1,
      projectile_speed = 1,
      recovery_time = 1,
    },
    
    wand_id = "lazershot",
    
  }
  player.x = world.x + (world.w-player.w)/2
  player.y = world.y + (world.h-player.h)/2
  
  player.shot = t()

  
  -- player.inventory = {
    -- winged_boots,
  -- }
  
  player.inventory = get_all_items()
  -- init player's inventory items effects
  for i, id in pairs(player.inventory) do
    if items[id] and items[id].effect then items[id].effect() end
  end
  
  add_object_y_sort(player, draw_player)

  
end

function get_player_mov_angle()
  return atan2(player.v.x, player.v.y)
end
function get_look_angle_player()
  return atan2(cam.x + btnv("mouse_x") - (player.x + player.w/2) ,cam.y + btnv("mouse_y") - (player.y + player.h/2) )
end

function get_look_angle(e)
  if e == player then return get_look_angle_player() end
end

function hurt_player(amount, recovery_time)
  if player.until_recovery > 0 then return end
  player.life = player.life - (amount or 0)
  
  player.until_recovery = (recovery_time or player.recovery_time) * player.buffs.recovery_time
end

function get_player_max_speed()
  return (player.dash_began and (player.dash_speed - (player.dash_speed - player.max_speed) * (t() - player.dash_began) / player.dash_time) 
          or player.max_speed) * player.buffs.movement_speed 
end

function update_player()

  local p = player
  
  p.until_recovery = p.until_recovery - dt()
  
  local acceleration = 800 * dt()
  
  if not SHOWING_MENU() then 
  -- if true then 
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
  
    p.x = mid(world.x + 64, p.x, world.x - 64 + world.w - p.w)
    p.y = mid(world.y + 64 - p.h*2/3, p.y, world.y - 64 + world.h - p.h)
  
  --
  
  p.anim_t = p.anim_t + dt() * (dist(p.v.x, p.v.y) > .2 and 1 or dist(p.v.x, p.v.y) < 1 and dist(p.v.x, p.v.y) or 0)

end

function draw_player()
  
  local a = get_look_angle_player()
  
  local s = flr(player.anim_t * 10)%2
  local fx = (a > -1/4 and a < 1/4) 

  if player.until_recovery < 0 or flr(player.until_recovery * 10) %2 == 0  then
    outlined( s, player.x, player.y, 1, 1, fx)
  end
  
  if player.msg then
  
    player.msg = nil
  
  end
  -- line(player.x + player.w/2, player.y + player.h/2, player.x + player.w/2 + cos(a) * 32, player.y + player.h/2 + sin(a) * 32, _p_n("yellow"))

end

function draw_shadow_player()
  spr( 2, player.x, player.y + 4)
end



