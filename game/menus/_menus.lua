  
do -- find all the enemies

  files = love.filesystem.getDirectoryItems( "game/menus/" )

  for k, file in ipairs(files) do
    if file ~= "_menus.lua" then
      file = file:sub( 1, #file - 4 )
      require("game/menus/"..file)
    end
  end
  
end


function init_menus()

end


function update_menus()
  if SHOWING_MENU() then
    if SHOWING_SHOP then update_shop()
    elseif SHOWING_QB then update_qb() end
  end  
end

function draw_menus()
  if SHOWING_MENU() then
    if SHOWING_SHOP then draw_shop()
    elseif SHOWING_QB then draw_qb() end
  end
end

function close_other_menus()
  close_shop()
  close_qb()
end