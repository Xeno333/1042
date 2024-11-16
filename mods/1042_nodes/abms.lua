
-- Fire ABMs

local rand = PcgRandom(math.random())


core.register_abm({
    label = "Fire Put Out",
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
    label = "Fire Dies",
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
    interval = 8,
    chance = 4,
    nodenames = {"group:burns"},
    neighbors = {"group:burning"},

    action = function(pos, node, active_object_count, active_object_count_wider)
        if rand:next(1, core.get_item_group(node.name, "burns")) == 1 then 
            if (core.get_item_group(node.name, "wood") or 0) > 0 and rand:next(1, 4) == 1 then
                core.set_node(pos, {name = "1042_nodes:charcoal"})
                
            else
                core.set_node(pos, {name = "1042_nodes:fire"})

            end
        end
    end
})





-- Affects


core.register_abm({
    label = "Burning Particles",
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





-- Melt/Cool



core.register_abm({
    label = "Node Melts",
    catch_up = true,
    interval = 4,
    chance = 4,
    nodenames = {"group:melts"},
    neighbors = {"group:burning"},
    action = function(pos, node, active_object_count, active_object_count_wider)
        local def = core.registered_nodes[node.name]
        if def._1042_melts_to then
            core.set_node(pos, {name = def._1042_melts_to})
        end
    end
})


core.register_abm({
    label = "Cool Molten Nodes",
    nodenames = {"group:molten",},
    neighbors = {"group:cools"},
    catch_up = true,
    interval = 1,
    chance = 1,
    catch_up = true,
    action = function(pos, node, active_object_count, active_object_count_wider)
        local def = core.registered_nodes[node.name]
        if def._1042_cools_to then
            core.set_node(pos, {name = def._1042_cools_to})
        end
    end
})





-- Iron Smithing


core.register_abm({
    label = "Cool Molten Iron (source)",
    nodenames = {"1042_nodes:molten_iron_source"},
    catch_up = true,
    interval = 32,
    chance = 2,
    catch_up = true,
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
    catch_up = true,
    action = function(pos, node, active_object_count, active_object_count_wider)
        if rand:next(1, 4) == 1 then
            core.set_node(pos, {name = "1042_nodes:iron_ingot"})
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
    nodenames = {"1042_nodes:charcoal"},
    neighbors = {"group:burning"},

    action = function(pos, node, active_object_count, active_object_count_wider)
        core.set_node(pos, {name = "1042_nodes:charcoal_burning"})
    end
})