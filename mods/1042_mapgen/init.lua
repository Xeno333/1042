core.log("action", "Loading 1042_mapgen...")

core.register_alias("mapgen_stone", "1042_nodes:stone")
core.register_alias("mapgen_water_source", "1042_nodes:water_source")


-- API
dofile(core.get_modpath("1042_mapgen") .. "/mapgen_api.lua")

-- Mapgen thread
core.register_mapgen_script(core.get_modpath("1042_mapgen") .. "/mapgen.lua")

core.register_on_generated(function(minp, maxp, seed)
    core.fix_light(minp, maxp)
end)

core.log("action", "1042_mapgen loaded.")