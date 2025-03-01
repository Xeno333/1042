
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



-- Plant growth
core.register_abm({
    label = "Plant growth",
    interval = 60,
    chance = 8,
    nodenames = {"group:growth"},
    neighbors = {"group:bio_mass", "air"},

    action = function(pos, node, active_object_count, active_object_count_wider)
        -- Biome mass based growth
        if core.get_item_group(node.name, "growth") == 1 then
            local rq_biomass = core.get_item_group(node.name, "growth_bio_mass")
            local nodes = core.find_nodes_in_area(vector.new(pos.x-3, pos.y-2, pos.z-3), vector.new(pos.x+3, pos.y+1, pos.z+3), {"group:bio_mass"}, true)

            for name, pos_s in pairs(nodes) do
                if core.get_item_group(name, "bio_mass") >= rq_biomass then
                    local rand = PseudoRandom(math.random())
                    for i=1, #pos_s*2 do
                        local p1 = rand:next(1, #pos_s)
                        local p2 = rand:next(1, #pos_s)
                        local temp = pos_s[p1]
                        pos_s[p1] = pos_s[p2]
                        pos_s[p2] = temp
                    end

                    for _, pos_l in pairs(pos_s) do
                        local new_pos = vector.new(pos_l.x, pos_l.y+1, pos_l.z)
                        local upper_node_name = core.get_node(new_pos).name
                        if upper_node_name == "air" or core.get_item_group(node.name, "bio_mass") > 0 then
                            if math.random(1, 20) == 1 then
                                core.set_node(new_pos, node) -- #fixme This makes some plants grow upside down and stuff if the rotation isnt right, we need to make it snap to the point it sides.
                                return
                            end
                        end
                    end
                end
            end
        end
    end
})




-- Effects


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

            texpool = {
                {
                    name = "1042_plain_node.png^[colorize:#ffee77:255",
                    scale = 0.5,
                    alpha_tween = {
                        0.5, 1,
                        style = "pulse",
                        reps = 2,

                    }
                },
                {
                    name = "1042_plain_node.png^[colorize:#ffee77:255",
                    scale = 0.25,
                    alpha_tween = {
                        0.5, 1,
                        style = "pulse",
                        reps = 2,

                    }
                },
                {
                    name = "1042_plain_node.png^[colorize:#ffdd88:255",
                    scale = 0.1,
                    alpha_tween = {
                        0.5, 1,
                        style = "pulse",
                        reps = 2,

                    }
                }
            }
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



-- Cooking

core.register_abm({
    label = "Cook",
    nodenames = {"group:cooks"},
    neighbors = {"group:burning"},
    catch_up = true,
    interval = 8,
    chance = 4,
    action = function(pos, node, active_object_count, active_object_count_wider)
        local def = core.registered_items[node.name]
        if rand:next(1, def.groups.cooks) == 1 then
            local cooks_to = def._1042_cooks_to
            if cooks_to then
                core.set_node(pos, {name = cooks_to})
            end
        end
    end
})