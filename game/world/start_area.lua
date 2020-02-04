
function init_start_area()
  
  world = {}
  
  world.x = 0
  world.y = 0
  
  world.w = 32*12
  world.h = 32*12

  area = {update = update_start_area, draw = draw_start_area, post_draw = post_draw_start_area, quit = quit_start_area}
  
  to_pit_zone = {
    x = 64,
    y = 64,
    w = 32,
    h = 32,
  }
  
  -- to_shop_zone = {
    -- x = world.w/2-32,
    -- y = world.h/2-32,
    -- w = 64,
    -- h = 64,
    -- sprite = 20 * 8,
  -- }
  
  to_shop_zone = {
    x = 64,
    y = world.h - 128 - 32,
    w = 64,
    h = 64,
    sprite = 20 * 8,
  }
  
  
  to_quest_board_zone = {
    x = world.w/2-16,
    y = world.h/2-64,
    w = 32,
    h = 32,
  }
  
  init_start_area_bg()
  
  if player then
    player.x = world.w/2 - player.w/2
    player.y = world.h/2 - player.h/2
  end
  
  add_log("here")
  
  sk = sk or {x = to_shop_zone.x + 2 + 32 + 16 , y = to_shop_zone.y + 40 - 25, ry = function() return sk.y + 4 + 16 end, draw = function() outlined(to_shop_zone.sprite + 3 , sk.x, sk.y, 1, 2) end}
  add_object_y_sort(sk, sk.draw)
  
  pbl = pbl or {x = to_shop_zone.x + 2 , y = to_shop_zone.y + 40, ry = function() return pbl.y + 16*.5 end, draw = function() spr(to_shop_zone.sprite + 8*3 , pbl.x, pbl.y, 1, 2) end}
  add_object_y_sort(pbl, pbl.draw)
  
  pbr = pbr or {x = to_shop_zone.x + 43, y = to_shop_zone.y + 40, ry = function() return pbr.y + 16*.5 end, draw = function() spr(to_shop_zone.sprite + 8*3 , pbr.x, pbr.y, 1, 2) end}
  add_object_y_sort(pbr, pbr.draw)
  
  ptl = ptl or {x = to_shop_zone.x + 2 , y = to_shop_zone.y + 2 , ry = function() return ptl.y + 16*.5 end, draw = function() spr(to_shop_zone.sprite + 8*3 , ptl.x, ptl.y, 1, 2) end}
  add_object_y_sort(ptl, ptl.draw)
  
  ptr = ptr or {x = to_shop_zone.x + 43, y = to_shop_zone.y + 2 , ry = function() return ptr.y + 16*.5 end, draw = function() spr(to_shop_zone.sprite + 8*3 , ptr.x, ptr.y, 1, 2) end}
  add_object_y_sort(ptr, ptr.draw)
  
  
  tono = {x = to_shop_zone.x -1, y = to_shop_zone.y + 56, ry = function() return tono.y + 5 end,
    draw = function () 
      outlined(to_shop_zone.sprite + 8*3 + 1, tono.x, tono.y, 2, 2) 
      outlined(to_shop_zone.sprite + 8*3 + 1, tono.x + 16 + 8, tono.y, 2, 2) 
      outlined(to_shop_zone.sprite + 8*3 + 1, tono.x + 16 + 8 + 16 + 8, tono.y, 2, 2) 
    end}
    
  add_object_y_sort(tono, tono.draw)
  
end
  
function init_start_area_bg()
  
  start_area_bg = new_surface (world.w, world.h)
  
  target(start_area_bg)  
    draw_floor()
    draw_walls()  
  target()
  
end

function update_start_area()
  if SHOWING_MENU() then return end
  
  hover_pit = point_in_rect(btnv("mouse_x"), btnv("mouse_y"), to_pit_zone.x - cam.x, to_pit_zone.y - cam.y, to_pit_zone.w, to_pit_zone.h)
  
  if hover_pit then mouse_msg = "(LMB) Pit" end
  
  if hover_pit and btnp("select") then
    area.quit()
    init_pit()
  end
  
  hover_shop = point_in_rect(btnv("mouse_x"), btnv("mouse_y"), to_shop_zone.x - cam.x, to_shop_zone.y - cam.y, to_shop_zone.w, to_shop_zone.h)
  
  if hover_shop then mouse_msg = "(LMB) Shop" end
  
  if btnr("select") and hover_shop then
    show_shop()
  end
  
  
  hover_quest_board = point_in_rect(btnv("mouse_x"), btnv("mouse_y"), to_quest_board_zone.x - cam.x, to_quest_board_zone.y - cam.y, to_quest_board_zone.w, to_quest_board_zone.h)
  
  if hover_quest_board then mouse_msg = "(LMB) Quest Board" end
  
  if btnr("select") and hover_quest_board then
    show_quest_board()
  end
  
  
  
end

function draw_start_area()

  spr_sheet (start_area_bg, 0, 0)
 
  rctf(to_pit_zone.x, to_pit_zone.y, to_pit_zone.w, to_pit_zone.h, _p_n("pink"))
  
  -- draw shop zone
  -- spr(to_shop_zone.sprite , to_shop_zone.x, to_shop_zone.y, 3, 3)
  
  
  rctf(to_quest_board_zone.x, to_quest_board_zone.y, to_quest_board_zone.w, to_quest_board_zone.h, _p_n("pink"))
 
end

function post_draw_start_area()
  
  -- if btn("g") then tono.x = tono.x - 100 * dt() end
  -- if btn("j") then tono.x = tono.x + 100 * dt() end
  -- if btn("y") then tono.y = tono.y - 100 * dt() end
  -- if btn("h") then tono.y = tono.y + 100 * dt() end
  
  -- add_log("x = " .. tono.x - to_shop_zone.x)
  -- add_log("y = " .. tono.y - to_shop_zone.y)
  
  -- draw shop roof
  outlined(to_shop_zone.sprite , to_shop_zone.x, to_shop_zone.y, 3, 3)
 
end

function quit_start_area()
  add_log("here")
  remove_from_y_draw(pbl)
  remove_from_y_draw(pbr)
  remove_from_y_draw(ptl)
  remove_from_y_draw(ptr)
  pbl = nil
  pbr = nil
  ptl = nil
  ptr = nil
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

function show_quest_board()
  close_other_menus()
  SHOWING_QB = true
  init_qb()
  
end

function SHOWING_MENU()
  return SHOWING_SHOP or SHOWING_QB
end

