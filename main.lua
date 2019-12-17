require("game/game")  -- where all the fun happens
require("game/palette")
require("game/random_functions")

require("sugarcoat/sugarcoat")
sugar.utility.using_package(sugar.S, true)

if CASTLE_PREFETCH then
  CASTLE_PREFETCH({
    "main.lua",
    "game/game.lua",
})
end

zoom = 2
GW = 700 / zoom
GH = 700 / zoom

function love.load()
  init_sugar("!Manaficator2!", GW, GH, zoom )
  -- screen_render_integer_scale(false)
  -- use_palette(palettes.bubblegum16)

  set_frame_waiting(30)
  
  love.math.setRandomSeed(os.time())
  love.mouse.setVisible(true)
  
  init_game()
end

function love.update(dt)
  update_game(dt)
end


function love.draw()
  draw_game()
end















