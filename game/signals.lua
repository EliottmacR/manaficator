

-- all things send signals

-- have a function per signal

-- signals change data

--when a quest is taken into account, have an init and a check to see if end

-- each quest can only be completed once

--------------

signals = {}
  
function init_signals()

  is_dead = {}

  for i, t in pairs(e_template) do
    is_dead[t.id] = 0
  end

end

function send_signal(signal, params)
  if signals[signal] then signals[signal](params) end
end

--------------

--------------

function enemies_killed()
  local count = 0
  for _, c in pairs(is_dead) do count = count + c end
  return count
end

function r_enemies_killed()
  return enemies_killed() - (is_dead and is_dead["acid_pool"] or 0)
end

--------------

signals.is_dead =  
  
  function(params)
    if not params or not params.e or not params.e.id then return end
    is_dead[params.e.id] = is_dead[params.e.id] + 1 
  end

--------------