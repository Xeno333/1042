




-- Speacal nodes

core.register_node("1042_nodes:amethyst", {
    description = "Amethyst",
    drawtype = "mesh",
    mesh = "crystal.obj",
    tiles = {"1042_plain_node.png^[colorize:#aa66aa:128"},
    use_texture_alpha = "blend",

    paramtype = "light",
    paramtype2 = "4dir",
    sunlight_propagates = true,
    walkable = true,
    buildable_to = false,

    selection_box = {
        type = "fixed",
        fixed = {-0.35, -0.5, -0.35, 0.35, 0.3, 0.35}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.35, -0.5, -0.35, 0.35, 0.3, 0.35}
    },

    light_source = 4,
    
    groups = {breakable_by_hand = 3, attached_node = 3},
})

core.register_node("1042_nodes:rock", {
    description = "Rock",
    drawtype = "mesh",
    mesh = "rock.obj",
    tiles = {"1042_plain_node.png^[colorize:#777777:128"},
    use_texture_alpha = "opaque",


    selection_box = {
        type = "fixed",
        fixed = {-0.4, -0.5, -0.4, 0.4, -0.2, 0.4}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.4, -0.5, -0.4, 0.4, -0.2, 0.4}
    },

    paramtype = "light",
    paramtype2 = "4dir",
    sunlight_propagates = true,
    walkable = true,
    buildable_to = false,
    
    groups = {breakable_by_hand = 2, attached_node = 3},
})



core.register_node("1042_nodes:sticks", {
    description = "Sticks",
    drawtype = "mesh",
    mesh = "sticks.obj",
    tiles = {"1042_plain_node.png^[colorize:#672307:172"},
    use_texture_alpha = "opaque",

    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    buildable_to = false,
    
    groups = {breakable_by_hand = 1, attached_node = 3, burns = 1},
})


core.register_node("1042_nodes:fire_pile", {
    description = "Fire Pile",
    drawtype = "mesh",
    mesh = "fire_pile.obj",
    tiles = {"1042_plain_node.png^[colorize:#672307:172"},
    use_texture_alpha = "opaque",

    paramtype = "light",
    sunlight_propagates = true,
    floodable = true,
    walkable = false,
    buildable_to = false,
    
    groups = {breakable_by_hand = 1, attached_node = 3, burns = 1},
})

core.register_craft({
    output = "1042_nodes:fire_pile",
    recipe = {
        {"", "1042_nodes:sticks", ""},
        {"1042_nodes:sticks", "", "1042_nodes:sticks"}
    }
})



--[[
core.register_abm({
    interval = 4,
    chance = 1,
    nodenames = {"1042_nodes:fire_pile"},
    action = function(pos, node, active_object_count, active_object_count_wider)
        core.add_particlespawner({
            amount = 128,
            time = 4,

            collisiondetection = true,
            object_collision = true,

            vel = {
                min = vector.new(-1, 0.5, -1),
                max = vector.new(1, 2, 1),
                bias = 0
            },

            acc = vector.new(0, 1, 0),

            size = {
                min = 0.5,
                max = 1
            },

            exptime = {
                min = 0.2,
                max = 0.5
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

            texture = "1042_plain_node.png^[colorize:#ff0000:144"
        })
    end
})]]