
projectile_t.kamehameha = {
  update = function(proj)
  
    proj.angle = get_look_angle(player) --  + irnd(.05)
    
    local d = 14  
    
    proj.x = player.x + player.w/2 + cos(proj.angle) * d
    proj.y = player.y + player.h/2 + sin(proj.angle) * d 
    
    proj.x2 = proj.x + proj.l * cos(proj.angle)
    proj.y2 = proj.y + proj.l * sin(proj.angle)
      
    if not proj.to_destroy then
    
      for i, e in pairs(enemies) do
        -- if dist_e1(e, proj) < proj.r + get_t(e).w/2 then -- collision
        local collision = boxSegmentIntersection(e.x,e.y,get_t(e).w,get_t(e).h, 
                                                  proj.x, proj.y,proj.x2,proj.y2)
        if collision then -- collision
          hit_ennemy(e, proj.dmg)
        end 
        
      end
      
      if not btn("shoot") then 
        to_destroy(proj)
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
    -- get_wand(player).linked_proj = nil
    proj.to_destroy = t()  
  end,
  
  draw = function(proj)
    line(proj.x, proj.y, proj.x2, proj.y2, proj.c)
  end,

}





