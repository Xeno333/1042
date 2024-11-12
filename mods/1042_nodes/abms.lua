
-- Fire ABMs

core.register_abm({
    label = "Fire put out",
    catch_up = true,
    interval = 4,
    chance = 4,
    nodenames = {"1042_nodes:fire"},
    neighbors = {"group:cools"},
    action = function(pos, node, active_object_count, active_object_count_wider)
        core.set_node(pos, {name = "air"})
    end
})

core.register_abm({
    label = "Fire dies",
    catch_up = true,
    interval = 4,
    chance = 1,
    nodenames = {"1042_nodes:fire"},
    without_neighbors = {"group:burns"},
    action = function(pos, node, active_object_count, active_object_count_wider)
        core.set_node(pos, {name = "air"})
    end
})

core.register_abm({
    label = "Spread Fire",
    catch_up = true,
    interval = 16,
    chance = 4,
    nodenames = {"group:burns"},
    neighbors = {"group:burning"},
    action = function(pos, node, active_object_count, active_object_count_wider)
        core.set_node(pos, {name = "1042_nodes:fire"})
    end
})



-- Melt

core.register_abm({
    label = "Node melts",
    catch_up = true,
    interval = 4,
    chance = 4,
    nodenames = {"group:melts"},
    neighbors = {"group:burning"},
    action = function(pos, node, active_object_count, active_object_count_wider)
        core.set_node(pos, {name = "1042_nodes:water_source"})
    end
})




-- Affects


core.register_abm({
    interval = 4,
    chance = 1,
    nodenames = {"group:burning"},
    neighbors = {"air"},
    action = function(pos, node, active_object_count, active_object_count_wider)
        core.add_particlespawner({
            amount = 32,
            time = 4,

            collisiondetection = true,
            object_collision = true,

            vel = {
                min = vector.new(-1, 1, -1),
                max = vector.new(1, 2, 1),
                bias = 0
            },

            acc = vector.new(0, 1, 0),

            size = {
                min = 0.5,
                max = 1
            },

            exptime = {
                min = 0.5,
                max = 1
            },

            bounce = {
                min = 0,
                max = 0.3
            },

            glow = 14,

            pos = {
                min = vector.new(pos.x-0.3,pos.y-0.5,pos.z-0.3),
                max = vector.new(pos.x+0.3,pos.y,pos.z+0.3),
                bias = 0
            },

            texture = "1042_plain_node.png^[colorize:#ffdd88:144"
        })
    end
})
