core.log("action", "Loading 1042_cooking...")

local path = core.get_modpath("1042_cooking")

cooking_1042 = {}

dofile(path.."/src/smelting.lua")
dofile(path.."/src/cooking.lua")
dofile(path.."/src/mold.lua")
dofile(path.."/src/oven.lua")


core.log("action", "1042_cooking loaded.")
