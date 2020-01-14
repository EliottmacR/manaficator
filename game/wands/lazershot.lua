
wands.lazershot = {

  name = "La Zer",
  
  desc = "The ranged version of lasersabers.",
  
  projectile_type = "ranged_laser",

  price = 1,
  
  firing_speed = .8,
  
  can_shoot = function(player)
    return player.shot + get_firing_speed(player) < t()
  end,
  
  shoot = function(player)
    local proj = {}
    
    proj.type = get_wand_p_t(player)
    
    proj.speed = 15
    proj.dmg = 2
    proj.l =  15
    proj.c = _p_n("red")
    
    proj.life = 2 * (.90 + rnd(.20))
    
    proj.angle = get_look_angle(player) --  + irnd(.05)
    
    local d = 10
    proj.x = player.x + player.w/2 + cos(proj.angle) * d
    proj.y = player.y + player.h/2 + sin(proj.angle) * d 
    
    new_projectile("player", proj)
  
  end,
  
  sprite = 0,
  
}