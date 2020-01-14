
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

  rctf( -32,  -32, world.w + 32*2, world.h + 32*2, _p_n("dorange")) 
  rctf(   0,    0,        world.w, world.h, _p_n("agreen"))
  
  for j = 1, world.h/32-2 do
    for i = 1, world.w/32-2 do
      local col = ((i + j%2) % 2 == 0 ) and _p_n("dorange") or _p_n("agreen")
      rctf( (i) * 32,  (j) * 32, 32, 32, col) 
    end
  end
  
  rctf(to_pit_zone.x, to_pit_zone.y, to_pit_zone.w, to_pit_zone.h, _p_n("ppink"))
  
  rctf(to_shop_zone.x, to_shop_zone.y, to_shop_zone.w, to_shop_zone.h, hover_shop and _p_n("pink") or _p_n("ppink"))

end


function show_shop()
  SHOWING_SHOP = true
  
  
  -- if not items_on_sale then
    -- items_on_sale = {{}, {}}
    
    -- I_O_S_CATEGORIES = { "Wands", "Accessories"}
    
    -- for i, w in pairs(wands) do 
      -- add(items_on_sale[1], i)
    -- end
    
    -- for i, i in pairs(items) do 
      -- add(items_on_sale[2], i)
    -- end  
    
  -- end
  
end

function SHOWING_MENU()
  return SHOWING_SHOP
end

