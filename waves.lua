waves = {}

spawning_enemies = false
current_wave = 0

time_until_spawn = 0
condition_met = false
timer_lvl_up = 2
time_leveled_up = 0

function init_waves()
  
  waves = {
    --[enemy_type] = remaining
    { -- 1
      [1] = 1,
      [2] = 0
    }
  }
  -- for i = 1, 10 do 
    -- waves[i] = { 5 + i * (2 - ceil(i/5)), i * 2}
  
  -- end
  -- for i = 1, 10 do 
    -- waves[i] = { 5 + i * (2 - ceil(i/5)), i * 2}
  
  -- end
  
  spawning_enemies = false
  current_wave = 0
  time_until_spawn = 0  
  time_before_lvl_up = .3
  timer_lvl_up = time_before_lvl_up
  
end

function begin_next_wave()
  
  if current_wave >= #waves then return end
  
  current_wave = current_wave + 1
  spawning_enemies = true
  log("Beginning wave ".. current_wave)
end

function update_waves(dt)
  if current_wave > #waves then return end
  
  if spawning_enemies then -- in wave
  
    time_until_spawn = time_until_spawn - dt 
 
    if time_until_spawn < 0 then   
      time_until_spawn = max(1 - current_wave*.12, .3)
      if not is_wave_ended() then
        init_enemy( random_enemy_type(current_wave))
      else
        spawning_enemies = false
        timer_lvl_up = time_before_lvl_up
      end
    end
    
  else
    timer_lvl_up = timer_lvl_up - dt
    
    if current_wave == 0 and time_since_launch > .2 then condition_met = true end
    
    if not show_lvl_up and count(enemies) < 1 and current_wave > 0 and timer_lvl_up < 0 and time_leveled_up < current_wave then 
      init_lvl_up() 
      show_lvl_up = true 
      screen_shake()
    end
    
    if condition_met then 
      begin_next_wave()
      condition_met = false
      show_lvl_up = false
      timer_lvl_up = time_before_lvl_up
    end    
  end

end

function random_enemy_type(current_wave)


  local indexes  = {}

  indexes = get_indexes(waves[current_wave])
  
  local choosen_id = indexes[1 + irnd(#indexes)]
  
  while waves[current_wave][choosen_id] < 1  do 
    choosen_id = 1 + irnd(#indexes)   
  end
  
  waves[current_wave][choosen_id] = waves[current_wave][choosen_id] - 1
  
  return choosen_id

end

function get_indexes(tab)
  local tabl = {}
  for ind, _ in pairs(tab)do
    add(tabl, ind)
  end
  return tabl
end

function is_wave_ended()  
  if current_wave == 0 then return true end
  for ind, remaining in pairs(waves[current_wave])do
    if remaining > 0 then return false end
  end
  return true
end