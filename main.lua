require("game")  -- where all the fun happens
require("random_functions")
require("sugarcoat/sugarcoat")
sugar.utility.using_package(sugar.S, true)

if CASTLE_PREFETCH then
  CASTLE_PREFETCH({
    -- "assets/background.wav",
    -- "assets/explosion.wav",
    -- "assets/explosion2.wav",
    -- "assets/launch.wav",
    -- "assets/selected.wav",
    -- "assets/selection.wav",
    
    -- "assets/help.png",
    -- "assets/hors.png",
    -- "assets/sound.png",
    -- "assets/no_sound.png",
    
    -- "SB_games/_SB_games.lua",
    -- "SB_games/coin_toss.lua",
    -- "SB_games/janken.lua",
    -- "SB_games/horse_race.lua",
    
    -- "screens/_screen_controller.lua",
    -- "screens/background.lua",
    -- "screens/choose_bets.lua",
    -- "screens/choose_game.lua",
    -- "screens/display_results.lua",
    -- "screens/generic_screen.lua",
    -- "screens/main_menu.lua",
    -- "screens/sb_game.lua",
    -- "screens/shop.lua",
    -- "screens/title_screen.lua",
    -- "screens/winground.lua",
    
    "game.lua",
    "main.lua",
    "pool.lua",
    "enemy.lua",
    "bullet.lua",
    "player.lua",
    "waves.lua",
    -- "random_functions.lua"
    
})
end

GW = 700
GH = 900
zoom = 3

function love.load()
  init_sugar("!Manaficator!", GW, GH, zoom )
  screen_render_integer_scale(false)
  use_palette(palettes.bubblegum16)
  
  _colors = {
    black = 0,
    dark_red = 1,
    light_red = 2,
    orange = 3,
    yellow = 4,
    white = 5,
    light_pink = 6,
    dark_pink = 7,
    light_purple = 8,
    dark_purple = 9,
    sea_blue = 10,
    sky_blue = 11,
    light_green = 12,
    green = 13,
    plastic_blue = 14,
    dark_blue = 15
  }
  
  
  palt(0, false)    
  
  set_frame_waiting(30)
  
  love.math.setRandomSeed(os.time())
  love.mouse.setVisible(true)
  
  load_music("assets/background.wav", "bgm", .2)
  music("bgm", true)
  
  init_game()
end

function love.update(dt)
  update_game(dt)
end


function love.draw()
  draw_game()
end















