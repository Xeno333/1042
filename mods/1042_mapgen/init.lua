dofile(core.get_modpath("1042_mapgen") .. "/mapgen_api.lua")

-- Mapgen thread
core.register_mapgen_script(core.get_modpath("1042_mapgen") .. "/mapgen.lua")


core.register_on_generated(function(minp, maxp, seed)
    core.fix_light(minp, maxp)
end)
