require("game/world/world")
require("game/player")
require("game/enemies/_enemies")
require("game/menus/_menus")
require("game/hud")
require("game/signals")
require("game/quests")
require("game/items") 

background_clr = 0

function init_game()
  
  log_str = {}

  init_controls()
  init_fonts()

  init_palette()
  
  -- object_list = castle.storage.get("object_list") or {}
  -- coins = castle.storage.get("coins")
  -- infos = castle.storage.get("infos") or {}
  
  load_png("spr_sheet", "assets/spr_sheet.png", nil, true) 
  spritesheet_grid (16, 16)
  state = "intro"
  
  
  init_world()
  init_items()
  init_player()
  
  cam = { x = 0, 
          y = 0}
          
  init_hud()
  
  init_signals()
  init_quests()
  
end

function update_game()

  update_world()
  
  update_enemies()
  update_player()
  update_projectiles()
  update_camera()
  
  update_hud()
  
end

function get_player_mov_angle()
  return atan2(player.v.x, player.v.y)
end

function update_camera()
  local angle = get_player_mov_angle()
  local mdist = 16
  
  local xoffset = cos(angle) * mdist * abs(player.v.x)/get_player_max_speed()
  local yoffset = sin(angle) * mdist * abs(player.v.y)/get_player_max_speed()
  
  cam.x = player.x + player.w/2 - GW/2 + xoffset
  cam.y = player.y + player.h/2 - GH/2 + yoffset
end


function draw_game()
  cls(background_clr)
  
  camera(cam.x, cam.y)
    draw_world()
    draw_projectiles()
    draw_shadows()
    y_sort_draw() 
    if area.post_draw then area.post_draw() end
    draw_cursor()
  camera()
  
  draw_hud()
  
  use_font("16")
  print_log()
  
end

function draw_shadows()
  draw_shadow_player()
  draw_shadow_enemies()
end

function init_controls()
  -- register_btn(0, 0, input_id("mouse_button", "lb"))
  -- register_btn(1, 0, input_id("mouse_button", "rb"))
  -- register_btn(2, 0, input_id("mouse_position", "x"))
  -- register_btn(3, 0, input_id("mouse_position", "y"))
  
  
  register_btn("up",    0, {input_id("keyboard", "z"), input_id("keyboard", "w")}) 
  register_btn("left",  0, {input_id("keyboard", "q"), input_id("keyboard", "a")}) 
  register_btn("down",  0,  input_id("keyboard", "s"))
  register_btn("right", 0,  input_id("keyboard", "d"))
  
  
  register_btn("space", 0,  input_id("keyboard", "space"))
  register_btn("quest", 0,  input_id("keyboard", "k"))
  
  register_btn("g", 0,  input_id("keyboard", "g"))
  register_btn("j", 0,  input_id("keyboard", "j"))
  register_btn("y", 0,  input_id("keyboard", "y"))
  register_btn("h", 0,  input_id("keyboard", "h"))
  
  register_btn("shoot" , 0, {input_id("mouse_button", "lb"),  input_id("mouse_button", "rb")})
  register_btn("select", 0,  input_id("mouse_button", "lb"))
  register_btn("back"  , 0,  input_id("mouse_button", "rb"))
  
  register_btn("mouse_x", 0, input_id("mouse_position", "x"))
  register_btn("mouse_y", 0, input_id("mouse_position", "y"))
  

end

function init_fonts()
  
  load_font("sugarcoat/TeapotPro.ttf", 44, "44", false)
  load_font("sugarcoat/TeapotPro.ttf", 32, "32", false)
  load_font("sugarcoat/TeapotPro.ttf", 24, "24", true)
  load_font("sugarcoat/TeapotPro.ttf", 16, "16", true)
  
end


function load_user_info()
  network.async(  
    function () 
      user = castle.user.getMe()
      my_id   = user.userId
      my_name = user.name or user.username
    end)
end
  

