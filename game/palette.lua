
--
-- Palette ------------------------------------------
--

function init_palette()

  _sugar_palette = {}
  _palette = {}
  
  add_color(0x000000, "pblack" )
  
  add_color(0x16171a, "black"  )
  add_color(0x7f0622, "red"    )
  add_color(0xd62411, "dorange")
  add_color(0xff8426, "orange" )  
  add_color(0xffd100, "yellow" )
  
  add_color(0xfafdff, "white"  )
  add_color(0xff80a4, "ppink"  )
  add_color(0xff2674, "pink"   )
  add_color(0x94216a, "purple" )
  add_color(0x430067, "dblue"  )
  
  add_color(0x234975, "ablue"  )
  add_color(0x68aed4, "lblue"  )
  add_color(0xbfff3c, "agreen" )
  add_color(0x10d275, "green"  )
  add_color(0x007899, "blue"   )
  
  add_color(0x002859, "ddblue" )
  
  add_color(0x922317, "brick_red" ) 
  
  add_color(0x45120c, "brown" )
  add_color(0x45120c, "bbrown" )
  add_color(0x230b36, "dpurple" )
  
  
  use_palette(_sugar_palette)
  
end

function add_color(value, name)
  -- _sugar_palette[#_sugar_palette + 1] = value
  -- _palette[#_palette] = name

  add(_sugar_palette, value)
  add(_palette, name)
end

function _p_n(name)
	for i, c in pairs(_palette) do
		if c == name then return i-1 end
	end
end

function _p_i(index)
	return _p_n(_palette[index]) or 1
end

function random_c()
  return _p_n(_palette[1 + irnd(#_palette-1)])
end

function all_colors_to(c)
  if c then
    for i=0,#_palette do
      pal(i,c)
    end
  else
    for i=0,#_palette do
      pal(i,i)
    end
  end
end
