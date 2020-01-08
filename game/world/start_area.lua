
function init_start_area()
  
  world = {}
  
  world.x = 0
  world.y = 0
  
  world.w = 32*17
  world.h = 32*17
  
  area = {update = update_start_area, draw = draw_start_area}
  
  
  to_pit_zone = {
    x = 0,
    y = 0,
    w = 32,
    h = 32,
  }
  
  
  
  
  
  
  
  
end

function update_start_area()

  if point_in_rect(player.x + player.w/2, player.y + player.h/2, to_pit_zone.x, to_pit_zone.y, to_pit_zone.w, to_pit_zone.h) then
    init_pit()
  end
  
end

function draw_start_area()

  rctf( -32,  -32, world.w + 32*2, world.h + 32*2, _p_n("dorange")) 
  rctf(   0,    0,        world.w, world.h, _p_n("agreen"))
  
  for j = 1, world.h/32-2 do
    for i = 1, world.w/32-2 do
      local col = ((i + j%2) % 2 == 0 ) and _p_n("dorange") or _p_n("agreen")
      rctf( (i) * 32,  (j) * 32, 32, 32, col) 
    end
  end
  
  rctf(to_pit_zone.x, to_pit_zone.y, to_pit_zone.w, to_pit_zone.h, _p_n("ppink"))

end




