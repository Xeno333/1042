core.log("action", "Loading 1042_smithing...")

local path = core.get_modpath("1042_smithing")

dofile(path.."/smelting.lua")
dofile(path.."/campfire/init.lua")


core.log("action", "1042_smithing loaded.")
