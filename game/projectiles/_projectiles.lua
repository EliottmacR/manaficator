
projectiles = {}

projectile_t = {}
  
do -- find all the projectiles_types

  files = love.filesystem.getDirectoryItems( "game/projectiles/" )

  for k, file in ipairs(files) do
    if file ~= "_projectiles.lua" then
      file = file:sub( 1, #file - 4 )
      require("game/projectiles/"..file)
    end
  end
  
end

n_proj_id = 1

function new_projectile(from, proj)
  
  proj.from = (p == player and "player" or "other") 
  proj.id = n_proj_id
  projectiles[n_proj_id] = proj
  n_proj_id = n_proj_id + 1
  
  return n_proj_id - 1
end

function update_projectiles()
  for _, p in pairs(projectiles) do projectile_t[p.type].update(p) end
end

function draw_projectiles()
  for _, p in pairs(projectiles) do projectile_t[p.type].draw(p) end
end


function to_destroy(proj)
  return projectile_t[proj.type].to_destroy(proj)
end

function destroy(proj)
  projectiles[proj.id] = nil
end





