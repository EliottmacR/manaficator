require("game/projectiles/_projectiles")

wands = {}
  
do -- find all the wands

  files = love.filesystem.getDirectoryItems( "game/wands/" )

  for k, file in ipairs(files) do
    if file ~= "_wands.lua" then
      file = file:sub( 1, #file - 4 )
      require("game/wands/"..file)
    end
  end
  
end

function shoot(p)
  wands[p.wand_id].shoot(p)
end

function wand_update(player)
  return wands[player.wand_id].update and wands[player.wand_id].update(player)
end

function get_wand(player)
  return wands[player.wand_id]
end

function get_wand_p_t(player)
  return get_wand(player).projectile_type
end

function can_shoot(p)
  return wands[p.wand_id].can_shoot(p)
end

function get_firing_speed(player)
  return (wands[player.wand_id] and wands[player.wand_id].firing_speed or 1) / (player.buffs.firing_speed or 1)
end
