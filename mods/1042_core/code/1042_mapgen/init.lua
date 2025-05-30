core.log("action", "Loading 1042_mapgen...")

core.register_alias("mapgen_stone", "1042_core:stone")
core.register_alias("mapgen_water_source", "1042_core:water_source")


-- API
dofile(core_1042.get_core_mod_path("1042_mapgen") .. "/mapgen_api.lua")

-- Mapgen thread
core.register_mapgen_script(core_1042.get_core_mod_path("1042_mapgen") .. "/mapgen.lua")

core.register_on_generated(function(minp, maxp, seed)
    core.fix_light(minp, maxp)
end)

core.log("action", "1042_mapgen loaded.")