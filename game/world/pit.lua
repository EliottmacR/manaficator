
function init_pit()

  world = {}
  
  world.x = 0
  world.y = 0
  
  world.w = 32*19
  world.h = 32*19

  waves = {}
  
  -- for i = 1, 5 do
    -- waves[i] = {
      -- enemies = {
        -- { type = e_types[i], to_spawn = i, }
      -- },
      -- spawn_delay = 2,
    -- }
  -- end
  
  local enemies = {}
  
  enemies["zombie"] = { type = "zombie", to_spawn = 25, }
  enemies["acid_cloud"] = { type = "acid_cloud", to_spawn = 25, }
  
  waves[1] = {
    enemies = enemies,
    spawn_delay = .06,
  }
  
  current_wave = 0
  init_wave()
  area = {update = update_pit, draw = draw_pit}
  
  
  pit_bg = new_surface (world.w, world.h)
  
  target(pit_bg)
  
    draw_floor()
    draw_walls()
  
  target()
end

function get_spawn_delay()
  return waves[current_wave].spawn_delay
end

function spawn_enemy()
  
  local choosen_type = get_random_type_left()
  if not choosen_type then return end
  
  waves[current_wave].enemies[choosen_type].to_spawn = waves[current_wave].enemies[choosen_type].to_spawn - 1
  new_enemy(choosen_type)
  
  return true
end

function get_random_type_left()
  
  local types = {}
  for i, e in pairs(waves[current_wave].enemies) do
    if e.to_spawn > 0 then add(types, e.type) end
  end
  
  return pick(types)
end


----------------


BETWEEN_WAVE_TIME = 2

function init_between_wave()
  pit_state = "between waves"
  b_w_timer = BETWEEN_WAVE_TIME
  update_pit = update_between_wave
end

function update_between_wave()
  b_w_timer = b_w_timer - dt()
  
  if b_w_timer < 0 then
    init_wave()
  end
end

-----------------------

function init_wave()
  current_wave = current_wave + 1
  
  if not waves[current_wave] then begin_endless_wave() return end
  
  spawn_timer = get_spawn_delay()
  begin_display_wave(current_wave)
  update_pit = update_wave
end

function update_wave()
  spawn_timer = spawn_timer - dt()
  if spawn_timer < 0 then
    
    if spawn_enemy() then 
      spawn_timer = get_spawn_delay()
    else
      init_between_wave()
    end
    
  end
end


---------------------

function begin_endless_wave()
  update_pit = nil_func
end


function draw_pit()
 
  spr_sheet (pit_bg, 0, 0)

end










