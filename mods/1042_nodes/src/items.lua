


local function hit_flint_with_iron(itemstack, player, pointed_thing)
    local node = nil
    if pointed_thing and pointed_thing.under then
        node = core.get_node(pointed_thing.under)
    end
    if node and node.name == "1042_nodes:flint" then
        core.sound_play("hit_flint_with_iron", {gain = 1, pos = pointed_thing.under, max_hear_distance = 16}, true)
        core.add_particlespawner({
            pos = pointed_thing.under,
            amount = 10,
            time = 0.1,

            collisiondetection = true,
            object_collision = true,
            collision_removal = true,

            vel = {
                min = vector.new(-2, 1, -2),
                max = vector.new(2, 4, 2),
                bias = 0
            },

            acc = vector.new(0, -9.8, 0),

            size = {
                min = 0.05,
                max = 0.3
            },

            exptime = {
                min = 0.2,
                max = 1
            },

            glow = 14,

            name = player:get_player_name(),

            texture = "1042_plain_node.png^[colorize:#ffcc66:144"
        })

        if math.random(1, 10) == 1 then
            local nodes = core.find_nodes_in_area_under_air(vector.add(pointed_thing.under, vector.new(-1, -1, -1)), vector.add(pointed_thing.under, vector.new(1, 1, 1)), "group:burns")
            if #nodes > 0 then
                achievements_1042.achieve(player, "oooo_fire")
                core.set_node(vector.add(nodes[math.random(1, #nodes)], vector.new(0, 1, 0)), {name="1042_nodes:fire"})
            end
        end
    end
end










core.register_node("1042_nodes:fire", {
    description = "Fire",
    drawtype = "firelike",
    tiles = {
        {
            name = "[combine:2x8:0,0=1042_plain_node.png\\^[colorize\\:#ff2200\\:128:0,2=1042_plain_node.png\\^[transformR90\\^[colorize\\:#ff3300\\:128:0,4=1042_plain_node.png\\^[transformR180\\^[colorize\\:#ff4400\\:128:0,6=1042_plain_node.png\\^[transformR270\\^[colorize\\:#ff3300\\:128",
            animation = {
                type = "vertical_frames",
                aspect_w = 2,
                aspect_h = 2,
                length = 1,
            }
        },
    },
    use_texture_alpha = "blend",

    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    floodable = true,
    buildable_to = false,

    light_source = 8,
    damage_per_second = 5,
    
    groups = {breakable_by_hand = 3, burning = 1},
})


-- Speacal nodes

core.register_node("1042_nodes:beryl", {
    description = "Beryl",
    drawtype = "mesh",
    mesh = "crystal.obj",
    tiles = {"1042_plain_node.png^[colorize:#66eecc:128"},
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

    light_source = 5,
    
    groups = {breakable_by_hand = 3, attached_node = 3},
})

core.register_node("1042_nodes:beryl_hanging", {
    description = "Hanging Beryl",
    drawtype = "mesh",
    mesh = "crystal_roof.obj",
    tiles = {"1042_plain_node.png^[colorize:#66eeee:128"},
    use_texture_alpha = "blend",

    paramtype = "light",
    paramtype2 = "4dir",
    sunlight_propagates = true,
    walkable = true,
    buildable_to = false,

    light_source = 5,
    
    groups = {breakable_by_hand = 3, attached_node = 4},
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

    sounds = {
        dig = {
            name = "stone_dig",
            gain = 0.3,
            pitch = 0.5
        },
        place = {
            name = "stone_walk",
            gain = 1,
            pitch = 0.5
        }
    },

    paramtype = "light",
    paramtype2 = "4dir",
    sunlight_propagates = true,
    walkable = true,
    buildable_to = false,
    
    groups = {breakable_by_hand = 2, attached_node = 3},
})

core.register_node("1042_nodes:flint", {
    description = "Flint",
    drawtype = "mesh",
    mesh = "flint.obj",
    tiles = {"1042_plain_node.png^[colorize:#07070d:128"},
    use_texture_alpha = "opaque",


    selection_box = {
        type = "fixed",
        fixed = {-0.4, -0.5, -0.4, 0.4, -0.2, 0.4}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.4, -0.5, -0.4, 0.4, -0.2, 0.4}
    },


    sounds = {
        dig = {
            name = "stone_dig",
            gain = 0.3,
            pitch = 0.75
        },
        place = {
            name = "stone_walk",
            gain = 0.5,
            pitch = 1.5
        }
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

    sounds = {
        dug = {
            name = "sticks",
            gain = 0.2,
            pitch = 1,
        }
    },
    
    groups = {breakable_by_hand = 1, attached_node = 3, burns = 1},
})



core.register_node("1042_nodes:iron_nugget", {
    description = "Iron Nugget",
    drawtype = "mesh",
    mesh = "nugget.obj",
    tiles = {"1042_plain_node.png^[colorize:#551111:128"},
    use_texture_alpha = "opaque",


    selection_box = {
        type = "fixed",
        fixed = {-0.1, -0.5, -0.1, 0.1, -0.3, 0.1}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.1, -0.5, -0.1, 0.1, -0.3, 0.1}
    },
    
    sounds = {
        dig = {
            name = "stone_dig",
            gain = 0.2,
            pitch = 1
        },
        place = {
            name = "stone_walk",
            gain = 0.5,
            pitch = 1.5
        }
    },

    _1042_on_use = hit_flint_with_iron,

    paramtype = "light",
    paramtype2 = "4dir",
    sunlight_propagates = true,
    walkable = true,
    buildable_to = false,
    
    groups = {breakable_by_hand = 2, attached_node = 3},
})
core_1042.register_loot({name = "1042_nodes:iron_nugget", max_count = 16})


-- #FIXME
core.register_node("1042_nodes:anvil", {
    description = "Anvil (WIP)",
    drawtype = "mesh",
    mesh = "anvil.obj",
    tiles = {"1042_plain_node.png^[colorize:#222222:128"},
    use_texture_alpha = "opaque",

    paramtype = "light",
    paramtype2 = "4dir",
    sunlight_propagates = true,
    walkable = true,
    buildable_to = false,

    stack_max = 1,

    selection_box = {
        type = "fixed",
        fixed = {-0.4, -0.5, -0.4, 0.4, 0.3, 0.4}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.4, -0.5, -0.4, 0.4, 0.3, 0.4}
    },

    light_source = 5,
    
    groups = {breakable_by_hand = 3, attached_node = 3},
})



core.register_node("1042_nodes:iron_ingot", {
    description = "Iron Ingot",
    drawtype = "nodebox",
    mesh = "crystal.obj",
    tiles = {"1042_plain_node.png^[colorize:#998888:200"},

    paramtype = "light",
    paramtype2 = "facedir",
    sunlight_propagates = true,
    walkable = true,
    buildable_to = false,

    node_box = {
        type = "fixed",
        fixed = {-0.35, -0.5, -0.2, 0.35, -0.2, 0.2}
    },
    selection_box = {
        type = "fixed",
        fixed = {-0.35, -0.5, -0.2, 0.35, -0.2, 0.2}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.35, -0.5, -0.2, 0.35, -0.2, 0.2}
    },

    sounds = {
        dig = {
            name = "stone_dig",
            gain = 2,
            pitch = 2
        },
        footstep = {
            name = "stone_walk",
            gain = 0.3,
            pitch = 2
        },
        place = {
            name = "stone_dig",
            gain = 1,
            pitch = 2
        }
    },

    _1042_on_use = hit_flint_with_iron,

    after_dig_node = function(pos, oldnode, oldmetadata, digger)
        achievements_1042.achieve(digger, "smelter")
    end,
    
    groups = {breakable_by_hand = 1, falling_node = 1},
})
core_1042.register_loot({name = "1042_nodes:iron_ingot", max_count = 6})


core.register_node("1042_nodes:pork_raw", {
    description = "Raw Pork",
    drawtype = "mesh",
    mesh = "pork.obj",
    tiles = {
        "1042_plain_node.png^[colorize:#ffbb88:128",
        "1042_plain_node.png^[colorize:#ffaa77:144",
        "1042_plain_node.png^[colorize:#ff9966:128"
    },
    use_texture_alpha = "opaque",

    paramtype = "light",
    paramtype2 = "facedir",
    sunlight_propagates = true,
    walkable = true,
    buildable_to = false,
    
    _1042_on_use = function(itemstack, user)
        return core_1042.eat(itemstack, user, 4, 2)
    end,

    _1042_cooks_to = "1042_nodes:pork_cooked",

    groups = {food = 1, breakable_by_hand = 1, attached_node = 3, cooks = 3},
})

core.register_node("1042_nodes:pork_cooked", {
    description = "Cooked Pork",
    drawtype = "mesh",
    mesh = "pork.obj",
    tiles = {
        "1042_plain_node.png^[colorize:#dd4422:128",
        "1042_plain_node.png^[colorize:#cc3311:144",
        "1042_plain_node.png^[colorize:#993322:128"
    },
    use_texture_alpha = "opaque",

    paramtype = "light",
    paramtype2 = "facedir",
    sunlight_propagates = true,
    walkable = true,
    buildable_to = false,
    
    _1042_on_use = function(itemstack, user)
        return core_1042.eat(itemstack, user, 8, nil)
    end,


    groups = {food = 1, breakable_by_hand = 1, attached_node = 3},
})