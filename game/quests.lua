--------------

-- when a quest is taken into account, have an init and a check to see if end

-- each quest can only be completed once

--------------


function init_quests()

  quest_board = {quest_chains = {}, selected_chains = {} }
  
  -- 3 available quests at all time
  
  -- something like 8 different quest chain

  -- have one that features redoable quests
  
  init_monstrology()
  
  quest_board.selected_chains = {1, 2, 3}
  
  -- init_feat()
                
                
  available_quests = {1, 2, 3}
  completed_quests = {}

end


function log_quest_status()
  for i, q in pairs(quests) do
    add_log(q.name .. " : " .. (q.collected and "Collected" or (is_in(i, available_quests) and ( q.check() and "Completed" or "Pending" ) or "Not Available")))
  end
end


function init_monstrology()
  
  monstrology = { name = "monstrology", quests = {}, current = 1}
  
  add( monstrology.quests,  { 
                  name = "Monstrology I", 
                  desc = "Kill 20 enemies", 
                  check = function() return r_enemies_killed() >= 20 end , 
                  progress_bar = function() return min(20, r_enemies_killed()) / 20 end ,
                  progress_text = function() return min(20, r_enemies_killed()).."/".. 20 end , 
                  collected = false, 
                })
  add( monstrology.quests,  { 
                  name = "Monstrology II", 
                  desc = "Kill 50 enemies", 
                  check = function() return r_enemies_killed() >= 50 end , 
                  progress_bar = function() return min(50, r_enemies_killed()) / 50 end ,
                  progress_text = function() return min(50, r_enemies_killed()).."/".. 50 end , 
                })
  add( monstrology.quests,  { 
                  name = "Monstrology III", 
                  desc = "Kill 100 enemies", 
                  check = function() return r_enemies_killed() >= 100 end ,
                  progress_bar = function() return min(100, r_enemies_killed()) / 100 end ,
                  progress_text = function() return min(100, r_enemies_killed()).."/".. 100 end , 
                })
  add( monstrology.quests,  { 
                  name = "Monstrology IV", 
                  desc = "Kill 200 enemies", 
                  check = function() return r_enemies_killed() >= 200 end ,
                  progress_bar = function() return min(200, r_enemies_killed()) / 200 end ,
                  progress_text = function() return min(200, r_enemies_killed()).."/".. 200 end , 
                })
                
  add(quest_board.quest_chains, copy_table(monstrology) ) 
  add(quest_board.quest_chains, copy_table(monstrology) ) 
  add(quest_board.quest_chains, copy_table(monstrology) )  
  
end

function init_feat()
  
  -- feat = { quests = {}, done = {}}
  
  -- add( feat.quests,  { 
                  -- name = "Poor Child", 
                  -- desc = "Die without killing any enemy", 
                  -- check = function() return r_enemies_killed() >= 20 end , 
                  
  -- add(quests, monstrology)       
end