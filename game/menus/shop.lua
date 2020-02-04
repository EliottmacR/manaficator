  
function init_shop_menu()

  shop_w = { }
  
  shop_w.w = GW * 3/4
  shop_w.h = GH * 2/3
  
  shop_w.x = GW/2 - shop_w.w/2
  shop_w.y = GH/2 - shop_w.h/2
  
  shop_w.choosen = 1
  shop_w.index = 1

  shop_w.cw = 50
  shop_w.ch = shop_w.h/4
  
  shop_w.rw = 30
  shop_w.rh = 50

end

function init_shop()
  init_shop_menu()
  shop_surf = shop_surf or new_surface(shop_w.w+1, shop_w.h+1, "shop_main")
  
  if not items_on_sale then
    items_on_sale = {{}, {}}
    
    I_O_S_CATEGORIES = { "Wands", "Accessories"}
    
    for i, w in pairs(wands) do 
      add(items_on_sale[1], i)
    end
    
    for i, it in pairs(items) do 
      add(items_on_sale[2], i)
    end  
    
  end
  
end

function show_shop()
  close_other_menus()
  SHOWING_SHOP = true
  
  init_shop()
  
end


function get_target_tab_shop(ind)
  return ind == 1 and wands or ind == 2 and items
end

function close_shop()
  SHOWING_SHOP = false
end

function update_shop()
  
  local s = shop_w
  
  if (btnr("select") and point_in_rect(btnv("mouse_x"), btnv("mouse_y"), s.x + s.w + 8, s.y - 20, 16, 16)) or btnr("back") then
    close_shop()
  end
  
  -- ARROWS
  
    -- left
      hover_l = point_in_rect(btnv("mouse_x") - s.x, btnv("mouse_y") - s.y, 10, s.h/2 - s.rh/2 - s.ch/4, s.rw, s.rh)
      if (btnp("select") and hover_l) then
        s.index = max(s.index - 1, 1) 
      end
    --
    
    -- right
      hover_r = point_in_rect(btnv("mouse_x") - s.x, btnv("mouse_y") - s.y, s.w - s.rw - 10, s.h/2 - s.rh/2 - s.ch/4, s.rw, s.rh)
      if (btnp("select") and hover_r) then 
        s.index = min(s.index + 1, count(items_on_sale[s.choosen])) 
      end
    --
  --
  
  -- CATEGORIES
  
    if s.choosen == 1 then
      hover_l_c = point_in_rect(btnv("mouse_x") - s.x, btnv("mouse_y") - s.y, 0, s.h - s.ch, s.w/2, s.ch)
    else
      hover_l_c = point_in_rect(btnv("mouse_x") - s.x, btnv("mouse_y") - s.y, 0, s.h - s.ch * 3/4, s.w/2, s.ch)
      if (btnp("select") and hover_l_c) then s.choosen, s.index = 1, 1 end
    end
      
    if s.choosen == 1 then
      hover_r_c = point_in_rect(btnv("mouse_x") - s.x, btnv("mouse_y") - s.y, s.w/2, s.h - s.ch * 3/4, s.w/2, s.ch)
      if (btnp("select") and hover_r_c) then s.choosen, s.index = 2, 1 end
    else
      hover_r_c = point_in_rect(btnv("mouse_x") - s.x, btnv("mouse_y") - s.y, s.w/2, s.h - s.ch, s.w/2, s.ch)
    end
    
  --  
  
end

function draw_shop()

  local s = shop_w
  
  -- TITLE
    use_font("32")
    c_cool_print("Shop", GW/2, GH/12 + sin(t() / 3) * 5)
  --
  
  -- CLOSING ZONE
    rctf(s.x + s.w + 8, s.y - 20, 16, 16, _p_n("black"))
    rctf(s.x + s.w + 8 + 2, s.y - 20 + 2, 16 - 4, 16 - 4, _p_n("red"))
  --
  
  target(shop_surf)
  
  -- BACKGROUND
    rctf(6, 5, s.w - 12, s.h - 12, _p_n("black"))
  --
  
  -- CATEGORIES
  
    -- left
      if s.choosen == 1 then
        rctf(0, s.h - s.ch, s.w/2, s.ch,       hover_l_c and _p_n("yellow") or _p_n("red"))
      else
        rctf(0, s.h - s.ch * 3/4, s.w/2, s.ch, hover_l_c and _p_n("yellow") or _p_n("white"))
      end
    --
    
    -- right
      if s.choosen == 1 then
        rctf(s.w/2, s.h - s.ch * 3/4, s.w/2, s.ch, hover_r_c and _p_n("yellow") or _p_n("white"))
      else
        rctf(s.w/2, s.h - s.ch, s.w/2, s.ch,       hover_r_c and _p_n("yellow") or _p_n("red"))
      end
    --
  
  --
  
  -- CONTENT
  
    local target_t = get_target_tab_shop(s.choosen)
    local ind = items_on_sale[s.choosen][s.index]
    
    -- local content = {name = target_t[ind].name, desc = target_t[ind].desc, price = target_t[ind].price}
    local content = {}
    content.name = target_t[ind].name
    content.desc = target_t[ind].desc
    content.price = target_t[ind].price
    
    use_font("32")
    c_cool_print(content.name, s.w/2, 15) 
    
    local str_h = str_height(content.name)
    use_font("16")
    c_cool_print(content.desc, s.w/2, 15 + str_h * 1.5, _p_n("black"), _p_n("white")) 
    
    add_log(_p_n("black") or "")
  
  
  --
  
  -- ARROWS
      -- no_r_arrow = s.index == count(items_on_sale[s.choosen])
      -- no_l_arrow = s.index == 1
    -- left
      rctf(10, s.h/2 - s.rh/2 - s.ch/4, s.rw, s.rh, (s.index == 1) and _p_n("black") or hover_l and _p_n("red") or _p_n("white"))
    --
    -- right
      rctf(s.w - s.rw - 10, s.h/2 - s.rh/2 - s.ch/4, s.rw, s.rh, (s.index == count(items_on_sale[s.choosen])) and _p_n("black") or  hover_r and _p_n("red") or _p_n("white"))
    --
  
  --
  
  -- OUTLINE
    rct(0, 0, s.w, s.h, _p_n("white"))
    for i = 1, 4 do
      rct(i, i, s.w - i*2, s.h - i*2, _p_n("black"))
    end
    rct( 5, 5, s.w - 10, s.h - 10, _p_n("white"))
  --
  
  target()
  spr_sheet(shop_surf, s.x, s.y)
end