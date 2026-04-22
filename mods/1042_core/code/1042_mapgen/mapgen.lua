-- mapgen.lua

-- Weather api
dofile(core_1042.get_core_mod_path("1042_weather") .. "/weather_api.lua")
-- schematics api
dofile(core_1042.get_core_mod_path("1042_schematics") .. "/schematics_api.lua")

-- Todo Make modable using normal mapgen definitions for biomes and schematics #fixme
mapgen_world = {}
mapgens = {}
function add_mapgen(miny, maxy, func, pr, temp)
    mapgens[#mapgens+1] = function(y1, y2)
        if y2 >= miny and y1 <= maxy then
            return func, pr, temp
        end
        return nil
    end
end


-- nodes

nodes = {}
for name, def in pairs(core.registered_nodes) do
    if def._mg_name then
        nodes[def._mg_name] = core.get_content_id(name)
    else
        local n, _ = string.gsub(name, ":", "__")
        nodes["_" .. n] = core.get_content_id(name)
    end
end

gems = {}
for name, def in pairs(core.registered_nodes) do
    if def.groups.gem == 1 then
        gems[#gems+1] = core.get_content_id(name)
    end
end
table.sort(gems)



-- Moduals

dofile(core_1042.get_core_mod_path("1042_mapgen") .. "/mapgen_api.lua")
dofile(core_1042.get_core_mod_path("1042_mapgen") .. "/structures.lua")
dofile(core_1042.get_core_mod_path("1042_mapgen") .. "/tree_system.lua")
-- Worlds
dofile(core_1042.get_core_mod_path("1042_mapgen") .. "/overworld_mg.lua")
dofile(core_1042.get_core_mod_path("1042_mapgen") .. "/world2_mg.lua")
dofile(core_1042.get_core_mod_path("1042_mapgen") .. "/void_mg.lua")





-- Mapgen
air = core.get_content_id("air")
ice = core.get_content_id("1042_core:ice")




core.register_on_generated(function(vm, minp, maxp, seed)
    --local stime = core.get_us_time()

    -- Core data
    local emin, emax = vm:get_emerged_area()
    local area = VoxelArea(emin, emax)
    local data = vm:get_data()
    local param2_data = vm:get_param2_data()

    -- Struct data
    local structs = {}

    -- Flags
    local updated_liquid = false
    local updated_param2 = false
    
    -- Void
    for _, f in pairs(mapgens) do
        local r, ipr, itemp = f(minp.y, maxp.y)
        if r ~= nil then
            -- data
            local pr, pr2, temp, humidity
            if not ipr then
                pr = PseudoRandom(seed + minp.x + minp.y + minp.z)
                pr2 = PseudoRandom(seed + 13572126 + minp.x + minp.y + minp.z)
            end
            if not itemp then
                temp = weather.get_temp_map(minp.x, minp.z)
                humidity = weather.get_humidity_map(minp.x, minp.z)
            end

            updated_param2, updated_liquid = r(
                minp, maxp,
                area, data, param2_data,
                pr, pr2,
                structs,
                temp, humidity
            )
            break
        end
    end

    vm:set_data(data)
    if updated_param2 then
        vm:set_param2_data(param2_data)
    end


    -- (OLD) #fixme this just skips chunks with overlaps, probably should make my own format and API for this to allow checking for fits
    --[[
        format_voxel_manip_data = {}
        format_voxel_manip_data:fits_in(<format_voxel_manip_data>)
        format_voxel_manip_data:add(<format_voxel_manip_data>)
        etc.
    ]]

    -- Structs
    if #structs > 0 then
        data = vm:get_data()

        for _, func in pairs(structs) do
            func(data)
        end

        vm:set_data(data)
    end
    
    if updated_liquid then
        vm:update_liquids()
    end

    --c = c + 1
    --avrg = ((avrg * (c-1)) + core.get_us_time() - stime) / c
    --print(math.floor(avrg) .. "us in " .. c)
end)
