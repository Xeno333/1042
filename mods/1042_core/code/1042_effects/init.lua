core.log("action", "Loading 1042_effects...")



local path = core_1042.get_core_mod_path("1042_effects")

dofile(path.."/effects_api.lua")
dofile(path.."/effects.lua")


core.log("action", "1042_effects loaded.")
