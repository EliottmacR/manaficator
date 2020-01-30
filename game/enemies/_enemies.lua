
enemies = {}
eid = 0

e_template = {}
e_types = {}
  
do -- find all the enemies

  files = love.filesystem.getDirectoryItems( "game/enemies/" )

  for k, file in ipairs(files) do
    if file ~= "_enemies.lua" then
      file = file:sub( 1, #file - 4 )
      require("game/enemies/"..file)
    end
  end
  
end

function new_enemy(e_type, params)
  if not e_template[e_type] then return end
  
  local e_t = e_template[e_type]
 
  local e = e_t.init(params)
  if not e then return end
  
  eid = eid + 1
  
  e.eid = eid
  enemies[e.eid] = e
  
  if get_a(e).y_sort then add_object_y_sort(enemies[e.eid], get_t(enemies[e.eid]).draw) end
  
  return eid
end

function update_enemies()
  for _, e in pairs(enemies) do e_template[e.id].update(e) end
end

function draw_shadow_enemies()
  for _, e in pairs(enemies) do e_template[e.id].draw_shadow(e) end
end

function kill_enemy(e)
  enemies[e.eid] = nil
  if get_a(e).y_sort then remove_from_y_draw(e) end
end


----------------------------------------


function get_init_position(e)

  local way = irnd(4)
  local x, y
  
  if way == 0 then
  
    -- top
    y = - get_t(e).h - irnd(16)
    x = irnd(world.w)
  elseif way == 1 then
  
    -- right
    x = world.w + irnd(16)
    y = irnd(world.h)
  
  elseif way == 2 then
  
    -- bottom
    y = world.h + irnd(16)
    x = irnd(world.w)
  
  else -- way == 3
  
    -- left
    x = irnd(get_t(e).w)
    y = irnd(world.h)
  end
  return x, y
end

function get_t(e)
  return e_template[e.id]
end

function get_a(e)
  return get_t(e) and get_t(e).attributes
end

function move_enemy_in_pit(e)
  
  local w = get_t(e).w
  local h = get_t(e).h
  
  if e.x > world.w - w - 64 then
    e.x = e.x - irnd(43) * dt()
  elseif e.x < 64 then
    e.x = e.x + irnd(43) * dt()
  end
  
  if e.y > world.h - h - 64  then
    e.y = e.y - irnd(43) * dt()
  elseif e.y < 64 then
    e.y = e.y + irnd(43) * dt()
  end
  
  if is_in_pit(e) then
    e.spawned = true
  end
  
end

function hit_ennemy(e, dmg)
  if get_t(e).hit then get_t(e).hit(e, dmg) end 
end

function is_in_pit(e)
  return e.x > 64 and e.x < world.w - get_t(e).w - 64 and e.y > 64 and e.y < world.h - get_t(e).h - 64
end






