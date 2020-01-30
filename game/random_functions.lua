
function count(tab)
  if not tab then return 0 end
  local nb = 0
  for i, j in pairs(tab) do nb = nb + 1 end
  return nb  
end

function mouse_in_rect( x1, y1, x2, y2, mx, my)
  if not x1 or not y1 or not x2 or not y2 then return end
  local mx = mx or btnv(2)
  local my = my or btnv(3)
  return mx > x1 and mx < x2 and my > y1 and my < y2
end

function chance(x) -- x gotta be between between 1 and 100 (both in)
  if x > 100 or x < 0 then return end
  return (rnd(100) <= x)
end

function here() log("here") end
function there() log("there") end

function easeInOut (timer, value_a, value_b, duration)
  
  timer = timer/duration*2  
	if (timer < 1) then return value_b/2*timer*timer + value_a end  
	timer = timer - 1  
 	return -value_b/2 * (timer*(timer-2) - 1) + value_a
end

function point_in_rect(px, py, x, y, w, h)
  return px > x and px < x + w and py > y and py < y + h 
end

function pick_distinct( amount, from )
  if not from or not amount or from == {} then return {} end
  
  to_return = {}  
  for i = 1, amount do
    local choosen = pick(from)    
    while check_in(choosen, to_return) do 
      choosen = pick(from)
    end
    add(to_return, choosen)    
  end
  
  return to_return
end

function is_in(value, tab)
  for index, val in pairs(tab) do
    if val == value then return true end
  end
  return false
end

function sign(x) return x >=0 and 1 or -1 end

function rct(x, y, w, h, col)
  return rect(x, y, x + w, y + h, col)
end
function rctf(x, y, w, h, col)
  return rectfill(x, y, x + w, y + h, col)
end



function copy(obj)
  if type(obj) ~= 'table' then return obj end
  local res = {}
  for k, v in pairs(obj) do res[copy(k)] = copy(v) end
  return res
end


function add_log(str)
  log_str[#log_str + 1] = str
end

function print_log(x, y)
  color(0)
  local l = ""
  for i = 1, #log_str do
    cool_print(l .. log_str[i], x , y)
    l = l .. "\n"
    log_str[i] = nil
  end
end

function c_cool_print_w_limited(str, x, y, w, inner_col, outer_col)

  -- local str_w = str_width(str)
  -- local str_h = str_height(str)
  
  -- local words = {}
  -- local word = ""
  
  -- for i = 1, #str do
    -- if str[i] ~= " " then 
      -- word = word .. str[i]
    -- else 
      -- add(words, word) 
      -- word = {}
    -- end
  -- end
  
  -- if #word ~= 0 then add(words, word) end
  
  
  -- count length and add words to line
  
  -- if line > w, del the last word and put it into the new line.
  
  -- continue while #str > 0
  
  cool_print(str, x - str_w/2, y - str_h/2, inner_col, outer_col )
  
end

function c_cool_print(str, x, y, inner_col, outer_col)

  local w = str_width(str)
  local h = str_height(str)
  
  cool_print(str, x - w/2, y - h/2, inner_col, outer_col )
end

function cool_print(str, x, y, inner_col, outer_col)
  if not str then return end
  
  local x = x or 0
  local y = y or 0
  
  local inner_col = inner_col or 1
  local outer_col = outer_col or 5
  local margin = 1
  color(outer_col)
  
  print(str, x-margin, y-margin)
  print(str, x-margin, y)
  print(str, x-margin, y+margin)
  
  print(str, x+margin, y-margin)
  print(str, x+margin, y)
  print(str, x+margin, y+margin)
  
  print(str, x, y-margin)
  print(str, x, y+margin)
  
  color(inner_col)
  print(str, x, y)

end

function c_print(str, x, y)
  local w = str_width(str)
  local h = str_height(str)
  
  print(str, x - w/2, y - h/2)

end

function str_width(str)
  str = str or ""
  return love.graphics.getFont():getWidth(str)
end
function str_height(str)
  str = str or ""
  return love.graphics.getFont():getHeight(str)
end





function dist_e1(e, entity2)
  
  local x1 = e.x + (get_t(e).w and get_t(e).w/2 or 0)
  local y1 = e.y + (get_t(e).h and get_t(e).h/2 or 0)
  
  local x2 = entity2.x + (entity2.w and entity2.w/2 or 0)
  local y2 = entity2.y + (entity2.h and entity2.h/2 or 0)
  
  return dist(x1-x2, y1-y2)
end


function dist_e2(entity1, entity2)
  
  local x1 = entity1.x + (entity1.w and entity1.w/2)
  local y1 = entity1.y + (entity1.h and entity1.h/2)
  
  local x2 = entity2.x + (entity2.w and entity2.w/2)
  local y2 = entity2.y + (entity2.h and entity2.h/2)
  
  return dist(x1-x2, y1-y2)
end

function nil_func() end

function boxSegmentIntersection(l,t,w,h, x1,y1,x2,y2)
  local dx, dy  = x2-x1, y2-y1

  local t0, t1  = 0, 1
  local p, q, r

  for side = 1,4 do
    if     side == 1 then p,q = -dx, x1 - l
    elseif side == 2 then p,q =  dx, l + w - x1
    elseif side == 3 then p,q = -dy, y1 - t
    else                  p,q =  dy, t + h - y1
    end

    if p == 0 then
      if q < 0 then return nil end  -- Segment is parallel and outside the bbox
    else
      r = q / p
      if p < 0 then
        if     r > t1 then return nil
        elseif r > t0 then t0 = r
        end
      else -- p > 0
        if     r < t0 then return nil
        elseif r < t1 then t1 = r
        end
      end
    end
  end

  local ix1, iy1, ix2, iy2 = x1 + t0 * dx, y1 + t0 * dy,
                             x1 + t1 * dx, y1 + t1 * dy

  -- if ix1 == ix2 and iy1 == iy2 then return ix1, iy1 end
  -- return ix1, iy1, ix2, iy2
  return true
end

function box_collide(x1, y1, w1, h1, x2, y2, w2, h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function outlined(sp, x, y, w, h, fx, flash)
  if not sp or not x or not y then return end
  
  local w = w or 1
  local h = h or 1
  
  all_colors_to(flash or _p_n("black"))
  spr(sp, x - 1, y - 1, w, h, fx) 
  spr(sp, x - 1, y,     w, h, fx) 
  spr(sp, x - 1, y + 1, w, h, fx) 
  
  spr(sp, x,     y - 1, w, h, fx) 
  spr(sp, x,     y + 1, w, h, fx) 
  
  spr(sp, x + 1, y - 1, w, h, fx) 
  spr(sp, x + 1, y,     w, h, fx) 
  spr(sp, x + 1, y + 1, w, h, fx) 
  
  
  all_colors_to(flash)
  spr(sp, x, y, w, h, fx) 
  if flash then all_colors_to() end
  
end
-- (3, player.x + player.w/2, player.y + player.h/2, get_look_angle_player() + .25, 1, 1, .5, .5) 
function a_outlined(sp, x, y, a, w, h, anchor_x, anchor_y, outline_color, from_to)
  if not sp or not x or not y then return end
  
  all_colors_to(outline_color or _p_n("black"))
  
  aspr(sp, x - 1, y - 1, a, w, h, anchor_x, anchor_y) 
  aspr(sp, x - 1, y,     a, w, h, anchor_x, anchor_y)    
  aspr(sp, x - 1, y + 1, a, w, h, anchor_x, anchor_y) 
  
  aspr(sp, x,     y - 1, a, w, h, anchor_x, anchor_y) 
  aspr(sp, x,     y + 1, a, w, h, anchor_x, anchor_y) 
  
  aspr(sp, x + 1, y - 1, a, w, h, anchor_x, anchor_y) 
  aspr(sp, x + 1, y,     a, w, h, anchor_x, anchor_y) 
  aspr(sp, x + 1, y + 1, a, w, h, anchor_x, anchor_y) 
  
  all_colors_to()
  
  for i, swap in pairs(from_to) do
    pal (swap[1],swap[2])
  end
  
  aspr(sp, x, y , a, w, h, anchor_x, anchor_y) 
  pal()
  
end


function collide_objobj(obj1, obj2)
  return get_a(obj1).collide and get_a(obj2).collide and (abs(obj1.x-obj2.x) < (get_t(obj1).w+get_t(obj2).w)/2
      and abs(obj1.y-obj2.y) < (get_t(obj1).h+get_t(obj2).h)/2)
end

function collide_objgroup(obj,group)
  for _, obj2 in pairs(group) do
    if obj2~=obj and get_a(obj2).collide then
      local bl = collide_objobj(obj,obj2)
      if bl then
        return obj2
      end
    end
  end
end

--
-- Y sorting -------------------------------------------------
--


_o = {} --_objects_to_draw


function add_object_y_sort(object, draw_func, y_offset)
  add(_o, {o = object, draw = draw_func, y_o = y_offset or 0})
end

function y_sort_draw()
  
  -- for i = 1, #_o do
  local dobjs = _o
  
  --sorting objects by depth
  for i=2,#dobjs do
   if dobjs[i-1].o:ry() + dobjs[i-1].y_o>dobjs[i].o:ry() + dobjs[i].y_o then
    local k=i
    while(k>1 and dobjs[k-1].o:ry() + dobjs[k-1].y_o>dobjs[k].o:ry() + dobjs[k].y_o) do
     local s=dobjs[k]
     dobjs[k]=dobjs[k-1]
     dobjs[k-1]=s
     k=k-1
    end
   end
  end
  
  --actually drawing
  for obj in all(dobjs) do
    obj.draw(obj.o)
  end
  -- end
end

function remove_from_y_draw(e)
  for i, ob in pairs(_o) do
    if ob.o.eid and ob.o.eid == e.eid then del_at(_o, i) end
  end
end

--
-- Y sorting -------------------------------------------------
--


















