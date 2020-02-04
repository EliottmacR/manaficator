  
function init_qb_menu()

  qb_w = { }
  
  qb_w.w = GW * 3/4
  qb_w.h = GH * 2/3
  
  qb_w.x = GW/2 - qb_w.w/2
  qb_w.y = GH/2 - qb_w.h/2
  
  qb_w.bw = qb_w.w
  qb_w.bh = qb_w.h/3

end

function init_qb()
  init_qb_menu()
  qb_surf = qb_surf or new_surface(qb_w.w+1, qb_w.h+1, "qb_main")
  
end

function show_qb()
  close_other_menus()
  SHOWING_QB = true
  
  init_qb()
  
end

function close_qb()
  SHOWING_QB = false
end

function update_qb()
  
  local s = qb_w
  
  if (btnr("select") and point_in_rect(btnv("mouse_x"), btnv("mouse_y"), s.x + s.w + 8, s.y - 20, 16, 16)) or btnr("back") then
    close_qb()
  end
  
end

function draw_qb()

  local s = qb_w
  
  -- TITLE
    use_font("32")
    c_cool_print("Quest Board", GW/2, GH/12 + sin(t() / 3) * 5)
  --
  
  -- CLOSING ZONE
    rctf(s.x + s.w + 8, s.y - 20, 16, 16, _p_n("red"))
  --
  
  target(qb_surf)
  
  -- BACKGROUND
    -- rctf(0, 0, s.w, s.h, _p_n("black"))
  --
  
  -- local y = 0
  -- Q1
    -- rctf(0, y, s.bw, s.bh, _p_n("white"))
    -- rctf(3, y + 3, s.bw - 6, s.bh - 6, _p_n("black"))
  --
  -- y = y + s.bh
  -- Q2
    -- rctf(0, y, s.bw, s.bh, _p_n("white"))
    -- rctf(3, y + 3, s.bw - 6, s.bh - 6, _p_n("black"))
  --
  -- y = y + s.bh
  -- Q3
    -- rctf(0, y, s.bw, s.bh, _p_n("white"))
    -- rctf(3, y + 3, s.bw - 6, s.bh - 6, _p_n("black"))
  --
  
  
  local y = 0
  
  for i = 1, 3 do
    local qc = quest_board.quest_chains[i]
    
    rctf(0, y, s.bw, s.bh, _p_n("pink"))
    rctf(3, y + 3, s.bw - 6, s.bh - 6, _p_n("black"))
    
    local q = qc.quests[qc.current]
    local name = q and q.name or ""
    local desc = q and q.desc or ""
    
    use_font("16")
    c_cool_print(name, s.bw/2, y + 10)
    
    use_font("24")
    c_cool_print(desc, s.bw/2, y + s.bh/2 - str_height(desc)/2)
    
    
    -- progress bar : 
    
    if q.progress_bar then
      local ratio = q.progress_bar()
      local text = q.progress_text()
      rctf(3, y + s.bh - s.bh/4 - 3, s.bw - 6, s.bh/4, _p_n("yellow"))
      rctf(6, y + s.bh - s.bh/4, s.bw - 12, s.bh/4 - 6, _p_n("red"))
      if ratio > 0 then
        rctf(6, y + s.bh - s.bh/4, (s.bw - 12) * ratio, s.bh/4 - 6, _p_n("green"))
      end
      if text then
        use_font("16")
        c_cool_print(text, s.bw/2, y + s.bh - s.bh/4 + 5)
      end
    end
    
    y = y + s.bh
  end
  
  
  
  
  
  target()
  spr_sheet(qb_surf, s.x, s.y)
end