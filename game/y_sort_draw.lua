
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
   if dobjs[i-1].o.ry() + dobjs[i-1].y_o>dobjs[i].o.ry() + dobjs[i].y_o then
    local k=i
    while(k>1 and dobjs[k-1].o.ry() + dobjs[k-1].y_o>dobjs[k].o.ry() + dobjs[k].y_o) do
     local s=dobjs[k]
     dobjs[k]=dobjs[k-1]
     dobjs[k-1]=s
     k=k-1
    end
   end
  end
  
  --actually drawing
  for obj in all(dobjs) do
    -- log("ty found = " .. obj.o.y)
    obj:draw()
  end
  -- end
end


















