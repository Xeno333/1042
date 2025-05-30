-- core_1042.core_path

local path = core_1042.core_path .. "/src/"
local mod_load_order = {
    path .. "1042_tests/init.lua",
    path .. "1042_achievements/init.lua",
    path .. "1042_nodes/init.lua",
    path .. "1042_tools/init.lua",
    path .. "1042_smithing/init.lua",
    path .. "1042_mobs/init.lua",
    path .. "1042_schematics/init.lua",
    path .. "1042_trees/init.lua",
    path .. "1042_weather/init.lua",

    path .. "1042_mapgen/init.lua",
}


for _, init_file in ipairs(mod_load_order) do
    dofile(init_file)
end

