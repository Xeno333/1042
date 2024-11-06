--[[core.register_abm({
    interval = 4,
    chance = 10,
    nodenames = {"group:melts"},
    action = function(pos, node, active_object_count, active_object_count_wider)
        core.set_node(pos, {name="1042_nodes:water_source"})
    end
})]]--