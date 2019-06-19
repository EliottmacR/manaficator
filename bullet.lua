
bullets = {}
count_bullets = 0


function init_bullet(from, x, y, angle, spd, size, life, param)
  local speed = spd or 10
  b = {  
    from = from,
    pos = {
      x = x,
      y = y},
    v = {
      x = cos(angle) * speed,
      y = sin(angle) * speed},  
      
    r = size or 8,
    angle = angle,
    scale_spr = 2,
    speed = speed,
    life = life or .6,
    m_life = life or .6,
    state = "spawned",
    moving = true,
    ricochet = 0,
    last_hit = nil,
    laser_length = 60 * bonuses.b_size_mult
  }

  param = param or {}  
  b.burning = param.burning
  b.electrified = param.electrified
  b.ricochet = param.ricochet
  b.is_laser = param.is_laser    
  b.is_boulder = param.is_boulder    
  b.is_nail = param.is_nail    
  
  count_bullets = count_bullets + 1
  bullets[count_bullets] = b
  
  return bullets[count_bullets]
  
end


function update_bullets(dt)
  
  for i, b in pairs(bullets) do
    b.life = b.life - dt
    
    if b.state == "dying" then
      b.state = "to_die"
      b.speed = 0
      b.v = {x = 0, y = 0}
    elseif b.state == "to_die" then
      bullets[i] = nil
    elseif b.state == "hit" then
      b.state = ""
    end
    
    update_vec_bullet(b, dt)
  
    if b.moving then
      update_pos_bullet(b)
    end    
    if b.life < 0 or b.pos.x < border_w - 8 or b.pos.x > ww - b.r - border_w + 8 or b.pos.y < border_h - 8 or b.pos.y > hh - b.r - border_h + 8 then
      b.state = "to_die"
    end
    
  end
  
  
end

function update_vec_bullet(b, dt) 
  if not b then return end
  
  local parameters = { bullet = b}
  for ind, func_id in pairs(on_b_v_update_skills) do
    if p.skills[func_id] then 
      skills[func_id](parameters) 
    end 
  end
  
end

function update_vector(b)
  b.v.x = cos(b.angle) * b.speed * (b.speed_mult or 1)
  b.v.y = sin(b.angle) * b.speed * (b.speed_mult or 1)
end

function find_closest_enemy(b, le)

  if count(enemies) < 1 then return end
  local m_dist = nil
  local x, y = 0, 0

  for i, e in pairs(enemies) do 
    if ( le == (e ~= le) ) then
      local d = dist(e.pos.x - b.pos.x, e.pos.y - b.pos.y)
      if not m_dist or m_dist > d then 
        m_dist = d
        x = e.pos.x
        y = e.pos.y
      end  
    end  
  end
  return x, y
end

function update_pos_bullet(b)
  b.pos.x = b.pos.x + b.v.x
  b.pos.y = b.pos.y + b.v.y
end

function collision_bullets(entity)
  local e = entity
  for i, b in pairs(bullets) do 
    if bullet_alive(b) and entity.class ~= b.from then
      local parameters = { bullet = b, enemy = e}
      
      if b.is_laser then
        if lasers(parameters) then fire_aspect(parameters) end    
      elseif b.is_boulder then
        for ind, func_id in pairs(on_b_col_enemy_skills) do
          if p.skills[func_id] then 
            skills[func_id](parameters) 
          end 
        end       
      else
        -- vanilla collision detection
        
        if dist(e.pos.x + e.w/2 - b.pos.x, e.pos.y + e.w/2 - b.pos.y) < e.w / 2 + b.r then 
          local no_skill = true
          for ind, func_id in pairs(on_b_col_enemy_skills) do          
            if p.skills[func_id] then 
              skills[func_id](parameters) 
              no_skill = false
            end             
          end   
          if no_skill then
            hit_bullet(b)
            hit_enemy(e)
          end
        end      
      end
    end
  end

end

function hit_bullet(bullet)
  -- if bullet.ricochet < 1 then
    bullet.state = "dying"
  -- else
    -- bullet.state = "hit"
    -- bullet.ricochet = bullet.ricochet - 1
  -- end
  -- log(bullet.ricochet)
end

function bullet_alive(bullet)
  return bullet.state ~= "to_die" and bullet.state ~= "dying"
end

function draw_bullets()
  
  for i, b in pairs(bullets) do
  
    if b.is_laser then
      laser_drawing(b)
    else    
      vanilla_drawing(b)
    end
    
  end
end

function laser_drawing(b)

  if (b.angle > .5/4 and b.angle <.5 * 3/4) or (b.angle > .5 + .5/4 and b.angle <.5 + .5 * 3/4) then
    big_line_v(b.pos.x, b.pos.y, b.pos.x + cos(b.angle) * b.laser_length , b.pos.y + sin(b.angle) * b.laser_length, 3)
  else
    big_line_h(b.pos.x, b.pos.y, b.pos.x + cos(b.angle) * b.laser_length , b.pos.y + sin(b.angle) * b.laser_length, 3)
  end
end


function vanilla_drawing(b)
  if b.state == "to_die" or b.state == "dying" then
    circfill(b.pos.x, b.pos.y, b.r + 8, _colors.orange)
  else
    local b_color = _colors.white

    if b.electrified or b.burning then

      if b.burning then
        b_color = _colors.light_red
        -- p_color = _colors.dark_red
      end
      
      if b.electrified then
        -- b_color = _colors.sky_blue
        p_color = _colors.white

        local r_w = b.r
                 
        local x = b.pos.x + cos(b.angle + 1/4) * r_w
        local y = b.pos.y + sin(b.angle + 1/4) * r_w                 

        for i = 0, 5 do                
          local r_x = cos(b.angle + 1/2) * r_w
          local r_y = sin(b.angle + 1/2) * r_w
                   
          local xx = irnd(r_w)
          local yy = irnd(r_w)
          circfill(x + cos(b.angle + 1/2) * xx * 3 + cos(b.angle - 1/4) * yy * 2 ,
                   y + sin(b.angle + 1/2) * xx * 3 + sin(b.angle - 1/4) * yy * 2 , 
                   irnd(3),
                   p_color)
        end
      end
    end 
    
    circfill(b.pos.x, b.pos.y, b.r, b_color)  
    
  end
end



















