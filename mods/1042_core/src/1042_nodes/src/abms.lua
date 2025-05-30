
local rand = PcgRandom(math.random())


-- Fire ABMs

core.register_abm({
    label = "Fire Put Out",
    catch_up = true,
    interval = 4,
    chance = 4,
    nodenames = {"1042_core:fire"},
    neighbors = {"group:cools"},
    action = function(pos, node, active_object_count, active_object_count_wider)
        core.set_node(pos, {name = "air"})
    end
})

core.register_abm({
    label = "Fire Dies",
    catch_up = true,
    interval = 4,
    chance = 1,
    nodenames = {"1042_core:fire"},
    without_neighbors = {"group:burns"},
    action = function(pos, node, active_object_count, active_object_count_wider)
        core.set_node(pos, {name = "air"})
    end
})

core.register_abm({
    label = "Spread Fire",
    catch_up = true,
    interval = 8,
    chance = 4,
    nodenames = {"group:burns"},
    neighbors = {"group:burning"},

    action = function(pos, node, active_object_count, active_object_count_wider)
        if rand:next(1, core.get_item_group(node.name, "burns")) == 1 then 
            if (core.get_item_group(node.name, "wood") or 0) > 0 and rand:next(1, 4) == 1 then
                core.set_node(pos, {name = "1042_core:charcoal"})

            else
                core.set_node(pos, {name = "1042_core:fire"})

            end
        end
    end
})


--[[
    Notes:
        This compeates with "Spread Fire"
        This adds the challenge of having to watch it to make sure it burns
]]
core.register_abm({
    label = "Light Charcoal",
    catch_up = true,
    interval = 8,
    chance = 4,
    nodenames = {"1042_core:charcoal"},
    neighbors = {"group:burning"},

    action = function(pos, node, active_object_count, active_object_count_wider)
        core.set_node(pos, {name = "1042_core:charcoal_burning"})
    end
})