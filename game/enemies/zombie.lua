
e_template.zombie = { 
  name = "Zombie",
  id = "zombie",
  
  w = 16,
  h = 16,
  
  attributes = {
    hp = 10,
    maxspeed = 5,
    dmg = 1,
    recovery_time = .1,
    collide = true,
  },
  
  init = function()
    local e_t = e_template.zombie
    local attributes = e_t.attributes
    
    local e = {
      id = e_t.id,
      hp = attributes.hp,
      speed = 0,
      buffs = {},
      ry = function(e) return e.y + 4 end,
    }
    
    e.x, e.y = get_init_position(e)
    
    e.d_per_sec = 100
    
    e.angle = atan2(player.x - e.x, player.y - e.y)
    e.last_hit = t() - get_a(e).recovery_time
    
    return e
    
  end,
  
  update = function(e)
    
    if not e.spawned then move_enemy_in_pit(e) return end 
    
    -- every frame, get closer from the player
    
    if e.hp < 0 then enemies[e.eid] = nil end
    
    local target = player
    
    local distance = dist(target.x, target.y, e.x, e.y) 
    
    if e.old_target then
      target = e.old_target
      distance = max(dist(target.x, target.y, e.x, e.y) , distance)
    end
    
    if distance > 60 then  
      e.angle = atan2(target.x - e.x, target.y - e.y)
      e.old_target = nil
    else
      if not e.old_target then
        e.old_target = {x = player.x, y = player.y}
      end
    end
    
    e.x = e.x + cos(e.angle) * e.d_per_sec * dt()
    e.y = e.y + sin(e.angle) * e.d_per_sec * dt()
    
    local acc = dt() * 10 * 5
    
    local enemy = collide_objgroup(e,enemies)
    if enemy then 
      e.x = e.x + sgn(e.x - enemy.x) * acc * 0.5
      e.y = e.y + sgn(e.y - enemy.y) * acc * 0.5
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
    
    outlined( 8*2 + s, e.x, e.y, 1, 1, fx, flash and _p_n("white"))
  end,
  
  draw_shadow = function(e)
    spr( 2, e.x, e.y + 4)
  end,
  
}







