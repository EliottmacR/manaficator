
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
  
  to_shop_zone = {
    x = world.w/2-16,
    y = world.h/2-32,
    w = 32,
    h = 32,
  }
  
end

function update_start_area()
  if SHOWING_MENU() then return end
  
  
  if point_in_rect(player.x + player.w/2, player.y + player.h/2, to_pit_zone.x, to_pit_zone.y, to_pit_zone.w, to_pit_zone.h) and btnp("select") then
    init_pit()
  end
  
  hover_shop = point_in_rect(btnv("mouse_x"), btnv("mouse_y"), to_shop_zone.x - cam.x, to_shop_zone.y - cam.y, to_shop_zone.w, to_shop_zone.h)
  
  if btnr("select") and hover_shop then
    show_shop()
  end
  
end

function draw_start_area()


  draw_walls()
  draw_floor()
  
 
end

function draw_floor ()
  rctf(0, 0, world.w ,world.h, _p_n("black"))
end

function draw_walls ()

  spritesheet_grid (32, 32)
  
  local s
  local ww = flr(world.w/32) + 1
  local wh = flr(world.h/32) + 1
  
  -- outer layer
  spr( 12, -64, -64) -- corner tl 
  for i = -1, ww - 1 do spr( 13, i * 32, -64) end -- top
  spr( 14, ww*32, -64) -- corner tr
  
  for j = -1, wh - 1 do spr( 16, -64, j * 32) end -- left
  
  spr( 20, -64, wh * 32) -- corner bl 
  for i = -1, ww - 1 do spr( 21, i * 32, wh * 32) end -- bottom
  spr( 22, ww*32, wh * 32) -- corner br
  
  for j = -1, wh - 1 do spr( 18, ww * 32, j * 32) end -- right
  
  
  -- inner layer
  spr( 24, -32, -32) -- corner tl 
  for i = 0, ww - 2 do spr( 25, i * 32, -32) end -- top
  spr( 26, (ww-1)*32, -32) -- corner tr
  
  for j = 0, wh - 2 do spr( 28, -32, j * 32) end -- left
  
  spr( 32, -32, (wh-1) * 32) -- corner bl 
  for i = 0, ww - 2 do spr( 33, i * 32, (wh-1) * 32) end -- bottom
  spr( 34, (ww-1)*32, (wh-1) * 32) -- corner br
  
  for j = 0, wh - 2 do spr( 30, (ww-1) * 32, j * 32) end -- right
  
  spritesheet_grid (16, 16)
  

end

function show_shop()
  SHOWING_SHOP = true
  
  init_shop()
  
end

function SHOWING_MENU()
  return SHOWING_SHOP
end

