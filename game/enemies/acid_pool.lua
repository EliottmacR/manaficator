
e_template.acid_pool = { 
  name = "Acid Pool",
  id = "acid_pool",
  
  w = 16,
  h = 16,
  
  attributes = {
    dmg = 1,
    life = 5,
    collide = false,
    y_sort = false,
  },
  
  init = function(params)
    if not params or not params.parent_id then return end
    local e_t = e_template.acid_pool
    local attributes = e_t.attributes
    
    local e = {
      id = e_t.id,
      life = attributes.life,
      speed = 0,
      state = -2,
      buffs = {},
      w = function (e) return get_t(e).w end,
      h = function (e) return get_t(e).h end,
    }
    
    parent = enemies[params.parent_id]
    
    e.x = parent.x
    e.y = parent.y
    
    return e
    
  end,
  
  update = function(e)
    e.life = e.life - dt()
    if e.life < 0 then kill_enemy(e) end
    
    if      e.life > get_a(e).life - .2 or e.life < .2 then e.state = 1
    elseif  e.life > get_a(e).life - .4 or e.life < .4 then e.state = 2
    else e.state = 3 end 
    
    if box_collide(player.x, player.y + player.h - 6, player.w, 6, e.x, e.y, e:w(), e:h()) then
      hurt_player(1)
    end
    
  end,
  
  hit = function(e, dmg)
  
  end,
  
  draw = function(e)
  end,
  
  draw_shadow = function(e)
    outlined( 8*4 + 3 + e.state, e.x, e.y, 1, 1, fx)
  end,
  
}
