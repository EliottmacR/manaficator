
wands.meteor_wand = {

  name = "Meteor Wand",
  
  desc = "You're not sure where you found it, or why it has that smell",
  
  projectile_type = "meteor",

  firing_speed = .2,
  
  can_shoot = function(player)
    return player.shot + get_firing_speed(player) < t()
  end,
  
  shoot = function(player)
    local proj = {}
    
    proj.type = get_wand_p_t(player)
    
    proj.dmg = 4
    proj.r =  5
    proj.c = _p_n("red")
    
    proj.time_to_crash = 1
    
    new_projectile("player", proj)
  
  end,
  
  sprite = 0,
  
}