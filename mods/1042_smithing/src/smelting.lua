local rand = PcgRandom(math.random())

-- Iron Smithing


core.register_abm({
    label = "Cool Molten Iron (source)",
    nodenames = {"1042_nodes:molten_iron_source"},
    catch_up = true,
    interval = 32,
    chance = 2,
    action = function(pos, node, active_object_count, active_object_count_wider)
        core.set_node(pos, {name = "1042_nodes:iron_slag"})
    end
})

core.register_abm({
    label = "Cool Molten Iron (flowing)",
    nodenames = {"1042_nodes:molten_iron_flowing"},
    catch_up = true,
    interval = 8,
    chance = 4,
    action = function(pos, node, active_object_count, active_object_count_wider)
        if rand:next(1, 4) == 1 then
            core.set_node(pos, {name = "1042_nodes:crude_iron"})
        else
            core.set_node(pos, {name = "1042_nodes:iron_slag"})
        end
    end
})

core.register_abm({
    label = "Melt Iron",
    catch_up = true,
    interval = 8,
    chance = 4,
    nodenames = {"1042_nodes:iron_nugget_block"},
    neighbors = {"1042_nodes:charcoal_burning"},

    action = function(pos, node, active_object_count, active_object_count_wider)
        core.set_node(pos, {name = "1042_nodes:molten_iron_source"})
    end
})


-- Charcoal

