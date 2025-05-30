
local pr = PcgRandom(core.get_mapgen_setting("seed"))


core.register_lbm({
    label = "Spawning fish",
    name = "1042_core:fish_spawning",
    run_at_every_load = true,
    nodenames = {"1042_core:water_source"},

    bulk_action = function(pos_list, dtime_s)
        for _, pos in ipairs(pos_list) do
            if pr:next(1, 5000) == 1 then
                core.add_entity(pos, "1042_core:fish")
            end
        end
    end,
})

core.register_lbm({
    label = "Spawning pigs",
    name = "1042_core:pig_spawning",
    run_at_every_load = true,
    nodenames = {"1042_core:turf"},

    bulk_action = function(pos_list, dtime_s)
        for _, pos in ipairs(pos_list) do
            if pr:next(1, 10000) == 1 then
                core.add_entity(vector.new(pos.x, pos.y+1, pos.z), "1042_core:pig")
            end
        end
    end,
})
