require("game/player")
require("game/enemy")
require("game/pit")
require("game/hud")
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
  
  state = "intro"
  
  init_items()
  init_pit()
  init_player()
  
  cam = { x = 0, 
          y = 0}

end

function update_game()
  
  if update_pit then update_pit() end
  
  update_enemies()
  update_player()
  update_projectiles()
  update_camera()
  
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
    draw_pit()
    draw_enemies()
    draw_projectiles()
    draw_player()
  camera()
  
  draw_hud()
  
  use_font("16")
  print_log()
  
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
  
  register_btn("shoot", 0, {input_id("mouse_button", "lb"),  input_id("mouse_button", "rb")})
  
  register_btn("mouse_x", 0, input_id("mouse_position", "x"))
  register_btn("mouse_y", 0, input_id("mouse_position", "y"))
  
  -- register_btn(11, 0, input_id("mouse_button", "scroll_y"))
end

function init_fonts()
  
  load_font("sugarcoat/TeapotPro.ttf", 44, "44", false)
  load_font("sugarcoat/TeapotPro.ttf", 32, "32", false)
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
  

