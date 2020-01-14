
wands.start_wand = {

  name = "Wooden stick",
  
  desc = "You're not sure where you found it, or why it has that smell",
  
  projectile_type = "orb",

  firing_speed = .2,
  
  price = 1,
  
  can_shoot = function(player)
    return player.shot + get_firing_speed(player) < t()
  end,
  
  shoot = function(player)
    local proj = {}
    
    proj.type = get_wand_p_t(player)
    
    proj.speed = 64 
    proj.dmg = 1
    proj.r =  5
    proj.c = _p_n("red")
    
    proj.life = 2 * (.90 + rnd(.20))
    
    proj.angle = get_look_angle(player) --  + irnd(.05)
    
    local d = 14  
    proj.x = player.x + player.w/2 + cos(proj.angle) * d
    proj.y = player.y + player.h/2 + sin(proj.angle) * d 
    
    new_projectile("player", proj)
  
  end,
  
  sprite = 0,
  
}