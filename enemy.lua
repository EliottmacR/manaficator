
enemies = {}

enemy_types = {}

function init_enemy_types()

  enemy_types = {
  
    {
      life = 4,
      speed = 4 ,
      minspeed = 3 ,
      maxspeed = 5 ,
      pattern = follow_player,
      color = 7
    },
    {
      life = 2,
      speed = 5.5 ,
      minspeed = 4.5 ,
      maxspeed = 6.5 ,
      pattern = follow_player,
      color = 8
    },
    {
      life = 3,
      speed = 6 ,
      minspeed = 5 ,
      maxspeed = 7 ,
      pattern = follow_player,
      color = 8
    }
  }

end

function init_enemy(enemy_type)
  
  local enemy_type = enemy_type or 2
  local e_t = enemy_types[enemy_type]
  
  local e = {
    class = "enemy",
    pos = { x = 0, y = 0},
    v   = { x = 0, y = 0}, 
    o_f = { x = 0, y = 0}, -- outside forces
      
    w = 16 * 2,
    h = 16 * 2,
    scale_spr = 2,
    
    spawning = true,
    
    state = "",
    life = e_t.life,
    speed = e_t.speed,
    minspeed = e_t.minspeed,
    maxspeed = e_t.maxspeed,
    pattern = e_t.pattern,
    type = enemy_type,
    color = e_t.color,
    last_hit = nil,
    
    burning = false,
    electrified = false,
    electrify_mult = 1
  }  
  
  local b_pos
  local a_pos
  local way = way or irnd(4)
  
  if way == 0 then 
    b_pos = {x = border_w + irnd(ww - border_w*2 - e.w) , y = - e.h}
    a_pos = {x = 0, y = border_h*1.5 + e.h}
  elseif way == 1 then 
    b_pos = {x = border_w + irnd(ww - border_w*2 - e.w) , y = hh}
    a_pos = {x = 0, y = - border_h*1.5 - e.h}
  elseif way == 2 then 
    b_pos = {x = - e.w , y = border_h + irnd(hh - border_h*2 - e.h)}
    a_pos = {x = border_w*1.5 + e.w, y = 0}
  elseif way == 3 then 
    b_pos = {x = ww , y = border_h + irnd(hh - border_h*2 - e.h)}
    a_pos = {x = -border_w*1.5 - e.w, y = 0}
  end
  
  e.b_pos = b_pos
  e.a_pos = a_pos
  
  e.pos.x = e.b_pos.x
  e.pos.y = e.b_pos.y
  
  e.spawn_time = time_since_launch
  
  add(enemies, e)
end

function update_enemies(dt)

  for i, e in pairs(enemies) do  
     
    if e.state == "hurt" then
      e.state = ""
    elseif e.state == "to_die" then 
      enemies[i] = nil 
    end
    update_enemy(e)    
  end
  
end


function update_enemy(e)
  
  if e.spawning then
    local t_anim = 1
    if time_since_launch - e.spawn_time >= t_anim then 
      e.spawning = nil
    else
      e.pos.x = easeInOut(time_since_launch - e.spawn_time, e.b_pos.x, e.a_pos.x, t_anim)
      e.pos.y = easeInOut(time_since_launch - e.spawn_time, e.b_pos.y, e.a_pos.y, t_anim)
    end
  else
    e.pattern(e)    
  end
  
  for i, oe in pairs(enemies) do
    if oe ~= e and chance(5) then
      local d = dist(e.pos.x, e.pos.y, oe.pos.x, oe.pos.y)
      if d < e.w then
        e.o_f.x = e.o_f.x + sign(e.pos.x - oe.pos.x)
        e.o_f.y = e.o_f.y + sign(e.pos.y - oe.pos.y)
      end
    end
    
  end
  
  e.pos.x = e.pos.x + e.o_f.x
  e.pos.y = e.pos.y + e.o_f.y
  
  e.o_f.x = e.o_f.x - e.o_f.x * (dt()*3)
  e.o_f.y = e.o_f.y - e.o_f.y * (dt()*3)
  
  if not e.spawning then
    local p = e
    if p.pos.x < border_w then p.pos.x = border_w
    elseif p.pos.x > ww - p.w - border_w then p.pos.x = ww - p.w - border_w end
    
    if p.pos.y < border_h then p.pos.y = border_h
    elseif p.pos.y > hh - p.h - border_h then p.pos.y = hh - p.h - border_h end  
  end          
  
  if e.burning then
    if time_since_launch - e.time_burned > burning_time then
      e.burning = false
      e.life = e.life - 1   
    end
  end
  
  if e.electrify_mult < 1 then  
    if time_since_launch - e.time_electrified > electrifying_time then    
      e.electrify_mult = e.electrify_mult + dt()      
      if e.electrify_mult >= 1 then
        e.electrify_mult = 1
        e.electrified = false
      end
    end    
  end
  
  collision_bullets(e) 
  
  if e.life < 1 then
    e.state = "to_die"
  end
end
function hit_enemy(e)
  e.life = e.life - 1
  e.state = "hurt"
end

function follow_player(e)

  local angle = atan2(e.pos.x - p.pos.x, e.pos.y - p.pos.y) + .5  
  
  e.angle = e.angle or angle
  
  e.speed = min(e.speed + e.maxspeed * dt() * 2, e.maxspeed) * ( e.electrify_mult or 1)
  local step = 0.02

  if abs(e.angle - angle)% 1 < .5 then
    if (e.angle < angle) then e.angle = e.angle + step
    else e.angle = e.angle - step
    end
  else
    if (e.angle < angle) then e.angle = e.angle - step
    else e.angle = e.angle + step
    end
  end
  
  e.angle = ((e.angle % 1) + 1) % 1    
  
  e.v.x = cos(e.angle) * e.speed 
  e.v.y = sin(e.angle) * e.speed   
  
  e.pos.x = e.pos.x + e.v.x
  e.pos.y = e.pos.y + e.v.y
  
end


function draw_enemies()
  color(0)
  
  for i, e in pairs(enemies) do
  
    if e.state == "to_die" or e.state == "hurt" then
      rectfill(e.pos.x, e.pos.y, e.pos.x + e.w, e.pos.y + e.h, _colors.black)
    else
      rectfill(e.pos.x, e.pos.y, e.pos.x + e.w, e.pos.y + e.h, e.color)
      
      if e.burning then        
        rectfill(e.pos.x + e.w - 5, e.pos.y - 15, e.pos.x + e.w + 5, e.pos.y - 5, _colors.light_red)
      end
      if e.electrified then        
        rectfill(e.pos.x - 5, e.pos.y - 15, e.pos.x + 5, e.pos.y - 5, _colors.sky_blue)
      end
    end
    
  end
  
end