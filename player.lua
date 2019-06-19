
p = {} -- player
-- local ww = 0
-- local hh = 0

local fire_cooldown = 0

fire_mods = {}

function init_fire_mods()
  fire_mods = 
  {
    { name = "basic",
      id = 1,
      start_d = 16,
      fire_rate = .25,
      b_size = 10,
      b_speed = 10,
      b_life = .8 ,
      b_rnd = .04} ,
      
    { name = "laser",
      id = 2,
      start_d = 0,
      fire_rate = 0,
      b_size = 1,
      b_speed = 30,
      b_life = .6 ,
      b_rnd = .04}  ,
      
    { name = "boulder",
      id = 3,
      start_d = 16,
      fire_rate = .2,
      b_size = 15,
      b_speed = 10,
      b_life = .6 ,
      b_rnd = .04}  
  }
end

function init_player()
 
  p = {  
    class = "player",
    pos = {
      x = ww / 2 - 16,
      y = hh / 2 - 16},
    v = {
      x = 0,
      y = 0},  
      
    w = 16 * 2,
    h = 16 * 2,
    scale_spr = 2,
    skills = {},
    shoot = single_bullet,
    shoot_times = 1,
    dispersion = 1/12/2,
    b_speed_diff = 0,
    fire_mod = 1,
    fire_cooldown = 0    
  }  
  -- add_skill(1)
  -- add_skill(1)
  
end

function update_player(dt)
  
  local mx = 7 * dt * 10
  p.fire_cooldown = p.fire_cooldown - dt
  -- 4 5 6 7
  -- z q s d
  if btn(4) then
    p.v.y = p.v.y - mx
  elseif btn(6) then
    p.v.y = p.v.y + mx
  end
  
  if btn(5) then
    p.v.x = p.v.x - mx 
  elseif btn(7) then
    p.v.x = p.v.x + mx
  end
  
  p.v.x = p.v.x * (1 - dt * 6)
  p.v.y = p.v.y * (1 - dt * 6)
  
  cap_speed_player()
  
  update_pos_player()
  
  if btn(0) and p.fire_cooldown < 0 then
    shoot()
  end
  
end

function shoot()
  
  local angle = atan2(p.pos.x + p.w/2 - btnv(2), p.pos.y + p.h/2 - btnv(3) + hh*1/3) + .5
  local f = fire_mods[p.fire_mod]
  
  local param = {}
    param.burning = p.skills[1]
    param.electrified = p.skills[2]
  
  for i = 1, p.shoot_times do
    p.shoot(angle - p.dispersion + rnd(p.dispersion * 2), f, param)
  end
  
  p.fire_cooldown = f.fire_rate / bonuses.fire_rate_mult      
  screen_shake()

end

function single_bullet(angle, fire_mod, param)
  local angle = angle
  local f = fire_mod
  init_bullet( "player", 
                p.pos.x + p.w/2 + cos(angle) * f.start_d,
                p.pos.y + p.h/2 + sin(angle) * f.start_d, 
                angle - f.b_rnd/2 + rnd(f.b_rnd), 
                f.b_speed * bonuses.b_speed_mult * ( 1 - p.b_speed_diff + rnd(p.b_speed_diff * 2)) ,
                f.b_size  * bonuses.b_size_mult, 
                f.b_life  * bonuses.b_range_mult, param )
end

function cap_speed_player()
  speed = dist(p.v.x, p.v.y)  
  local max_speed = 10  
  if speed > max_speed then
    p.v.x = p.v.x / speed * max_speed
    p.v.y = p.v.y / speed * max_speed
  end
end

function update_pos_player()
  
  p.pos.x = p.pos.x + p.v.x
  p.pos.y = p.pos.y + p.v.y
  
  
  if p.pos.x < border_w then p.pos.x = border_w
  elseif p.pos.x > ww - p.w - border_w then p.pos.x = ww - p.w - border_w end
  
  if p.pos.y < border_h then p.pos.y = border_h
  elseif p.pos.y > hh - p.h - border_h then p.pos.y = hh - p.h - border_h end  

end

function draw_player()
  rectfill(p.pos.x, p.pos.y, p.pos.x + p.w, p.pos.y + p.h, _colors.orange)
  local angle = atan2(p.pos.x + p.w/2 - btnv(2), p.pos.y + p.h/2 - btnv(3) + hh*1/3) + .5
  
  local c = cos(angle)
  local s = sin(angle)
  
  line(p.pos.x + p.w/2 + c * 32,
       p.pos.y + p.h/2 + s * 32, 
       p.pos.x + p.w/2 + c * 64, 
       p.pos.y + p.h/2 + s * 64, 
       _colors.white)
  
end