
function init_start_area()
  
  world = {}
  
  world.x = 0
  world.y = 0
  
  world.w = 32*17
  world.h = 32*17
  
  area = {update = update_start_area, draw = draw_start_area}
  
  to_pit_zone = {
    x = 64,
    y = 64,
    w = 32,
    h = 32,
  }
  
  to_shop_zone = {
    x = world.w/2-16,
    y = world.h/2-32,
    w = 32,
    h = 32,
  }
  
  init_start_area_bg()
  
  
  
  
  
  
  
  
  
end
  
function init_start_area_bg()
  
  start_area_bg = new_surface (world.w, world.h)
  
  target(start_area_bg)
  
    draw_floor()
    draw_walls()
  
  target()
  -- local screen = get_target ()
  
  -- target(start_area_bg)
  -- start_area_bg = spr_sheet (screen, 0, 0)
  -- target()
  
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

  spr_sheet (start_area_bg, 0, 0)
 
  rctf(to_pit_zone.x, to_pit_zone.y, to_pit_zone.w, to_pit_zone.h, _p_n("pink"))
  rctf(to_shop_zone.x, to_shop_zone.y, to_shop_zone.w, to_shop_zone.h, _p_n("pink"))
 
end

function draw_floor ()

  spritesheet_grid (32, 32)
  
  for i = 2, world.w/32 -3 do
    for j = 2, world.h/32 -3 do
      spr( 9 * 4 ,i * 32, j*32)
    end
  end
  
  spritesheet_grid (16, 16)
  
end

function draw_walls ()

  spritesheet_grid (32, 32)
  
  local s
  local ww = flr(world.w/32)-1
  local wh = flr(world.h/32)-1
  
  pal (_p_n("red"), _p_n("brick_red"))
  pal (_p_n("brick_red"), _p_n("red"))
  
  -- outer layer
  spr( 12, 0, 0) -- corner tl 
  for i = 1, ww - 1 do spr( 13, i * 32, 0) end -- top
  
  spr( 14, ww*32, 0) -- corner tr
  
  for j = 1, wh - 1 do spr( 16, 0, j * 32) end -- left
  
  spr( 20, 0, wh * 32) -- corner bl 
  for i = 1, ww - 1 do spr( 21, i * 32, wh * 32) end -- bottom
  spr( 22, ww*32, wh * 32) -- corner br
  
  for j = 1, wh - 1 do spr( 18, ww * 32, j * 32) end -- right
  
  
  -- inner layer
  spr( 24, 32, 32) -- corner tl 
  for i = 2, ww - 2 do spr( 25, i * 32, 32) end -- top
  spr( 26, (ww-1)*32, 32) -- corner tr
  
  for j = 2, wh - 2 do spr( 28, 32, j * 32) end -- left
  
  spr( 32, 32, (wh-1) * 32) -- corner bl 
  for i = 2, ww - 2 do spr( 33, i * 32, (wh-1) * 32) end -- bottom
  spr( 34, (ww-1)*32, (wh-1) * 32) -- corner br
  
  for j = 2, wh - 2 do spr( 30, (ww-1) * 32, j * 32) end -- right
  
  pal ( )
  
  spritesheet_grid (16, 16)
  

end

function show_shop()
  SHOWING_SHOP = true
  
  init_shop()
  
end

function SHOWING_MENU()
  return SHOWING_SHOP
end

