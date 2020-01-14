
wands.laser_wand = {

  name = "Kamehamewand",
  
  desc = "Born from a fan's creativity",
  
  projectile_type = "kamehameha", 
  
  firing_speed = 1.5,
  
  price = 1,
  
  -- activated = false,
  
  can_shoot = function(player)
    return not projectiles[get_wand(player).linked_proj]
  end,

  shoot = function(player)
  
    local proj = {}
    
    proj.dmg = .5
    proj.l =  60
    proj.c = _p_n("red")
    
    proj.life = 1
    
    proj.angle = get_look_angle(player) --  + irnd(.05)
    
    local d = 14  
    
    proj.x = player.x + player.w/2 + cos(proj.angle) * d
    proj.y = player.y + player.h/2 + sin(proj.angle) * d 
    
    proj.type = get_wand_p_t(player)
    
    get_wand(player).linked_proj = new_projectile("player", proj)
    
  end,
  
  sprite = 0,
  
}