require("game/world/start_area")
require("game/world/pit")

function init_world()
  -- init_start_area()
  init_pit()
end

function update_world()
  if area.update then area.update() end
end

function draw_world()
  if area.draw then area.draw() end
end




