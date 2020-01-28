
e_template.acid_cloud = { 
  name = "Acid Cloud",
  id = "acid_cloud",
  
  w = 16,
  h = 16,
  
  attributes = {
    hp = 10,
    maxspeed = 5,
    dmg = 1,
    recovery_time = .1,
    collide = false,
    travel_d = 16*8,
  },
  
  init = function()
    local e_t = e_template.acid_cloud
    local attributes = e_t.attributes
    
    local e = {
      id = e_t.id,
      hp = attributes.hp,
      speed = 0,
      buffs = {},
      ry = function(e) return e.y + 4 end,
    }
    
    e.x, e.y = get_init_position(e)
    
    e.d_per_sec = 25
    
    e.angle = atan2(player.x - e.x, player.y - e.y)
    e.last_hit = t() - get_a(e).recovery_time
    
    return e
    
  end,
  
  update = function(e)
    
    if not e.spawned then move_enemy_in_pit(e) return end 
    
    -- every frame, get closer from the player
    
    if e.hp < 0 then enemies[e.eid] = nil end
    
    local target = e.target
    
    if e.is_waiting and e.is_waiting > 0 then
      e.is_waiting = e.is_waiting - dt()
      add_log("attack")
      
    elseif not e.target then
    
      e.target = {}
      local target = e.target
      
      local a = rnd(1)
      
      target.x = e.x + get_a(e).travel_d * (.75 + rnd(.5)) * cos(a)
      target.y = e.y + get_a(e).travel_d * (.75 + rnd(.5)) * sin(a)
      
      target.x = mid(world.x + 80, target.x, world.x + world.w - get_t(e).w - 80)
      target.y = mid(world.y + 80, target.y, world.y + world.h - get_t(e).h - 80)
      
      e.angle = atan2(target.x - e.x, target.y - e.y)
        
      
    else
    
      e.x = e.x + cos(e.angle) * e.d_per_sec * dt()
      e.y = e.y + sin(e.angle) * e.d_per_sec * dt()
      
      if dist(target.x - e.x, target.y - e.y) < 8 then 
        e.is_waiting = 1
        e.target = nil
      end
      
    end
    
    --world boundaries
      e.x = mid(world.x + 64, e.x, world.x + world.w - get_t(e).w - 64)
      e.y = mid(world.y + 64, e.y, world.y + world.h - get_t(e).h - 64)
    --
    
  end,
  
  hit = function(e, dmg)
    if e.last_hit + get_a(e).recovery_time < t() then
      e.last_hit = t()
      e.hp = e.hp - (dmg or 0)
      
    end
  end,
  
  draw = function(e)    
    local flash = (e.last_hit + get_a(e).recovery_time > t())  
    local a = e.angle
    local s = flr(t()%2) 
    local fx = (a > -1/4 and a < 1/4)
  
    outlined( 8*4 + s, e.x, e.y, 1, 1, fx, flash and _p_n("white"))
  end,
  
  draw_shadow = function(e)
    spr( 2, e.x, e.y + 4)
  end,
  
}







