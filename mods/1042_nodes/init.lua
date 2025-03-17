core.log("action", "Loading 1042_nodes...")



local path = core.get_modpath("1042_nodes")

dofile(path.."/src/trees.lua")
dofile(path.."/src/items.lua")
dofile(path.."/src/nodes.lua")
dofile(path.."/src/plants.lua")
dofile(path.."/src/liquids.lua")
dofile(path.."/src/abms.lua")


core.log("action", "1042_nodes loaded.")
