
projectile_t.orb = {
  update = function(proj)
  
    if not proj.to_destroy then
      proj.life = proj.life - dt()
      
      if proj.life < 0 then 
        to_destroy(proj)
      end
      
      proj.x = proj.x + cos(proj.angle) * proj.speed * dt() 
      proj.y = proj.y + sin(proj.angle) * proj.speed * dt() 

      local x = mid(world.x, proj.x, world.x + world.w - proj.r)
      local y = mid(world.y, proj.y, world.y + world.h - proj.r)
      
      if proj.x ~= x or proj.y ~= y then 
        to_destroy(proj)
      end
      
      for i, e in pairs(enemies) do
        if dist_e1(e, proj) < proj.r + get_t(e).w/2 then -- collision
          enemies[i] = nil
          to_destroy(proj)
          break
        end 
      end
      
    else
      if t() - proj.to_destroy > dt() * 2 then 
        destroy(proj) 
      else
        proj.c = proj.c == _p_n("yellow") and _p_n("white") or _p_n("yellow") 
      end 
    end
    
  end,
    
  to_destroy = function(proj)
    proj.to_destroy = t() 
    proj.c = _p_n("yellow") 
    proj.r = proj.r * 1.5
  end,
  
  draw = function(proj)
    circfill(proj.x, proj.y, proj.r, proj.c)
  end,

}



