core.log("action", "Loading 1042_smithing...")

local path = core_1042.get_core_mod_path("1042_smithing")

cooking_1042 = {}

dofile(path.."/src/smelting.lua")
dofile(path.."/src/cooking.lua")
dofile(path.."/src/mold.lua")
dofile(path.."/src/oven.lua")


core.log("action", "1042_smithing loaded.")
