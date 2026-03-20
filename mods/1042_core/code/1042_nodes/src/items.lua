
local function hit_flint_with_iron(itemstack, player, pointed_thing)
    local node = nil
    if pointed_thing and pointed_thing.under then
        node = core.get_node(pointed_thing.under)
    end
    if node and node.name == "1042_core:flint" then
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

            texture = "1042_flint.png"
            --texture = "1042_plain_node.png^[colorize:#ffcc66:144"
        })

        if math.random(1, 10) == 1 then
            local nodes = core.find_nodes_in_area_under_air(vector.add(pointed_thing.under, vector.new(-1, -1, -1)), vector.add(pointed_thing.under, vector.new(1, 1, 1)), "group:burns")
            if #nodes > 0 then
                achievements_1042.achieve(player, "oooo_fire")
                core.set_node(vector.add(nodes[math.random(1, #nodes)], vector.new(0, 1, 0)), {name="1042_core:fire"})
            end
        end
    end
end

achievements_1042.register_achievement("oooo_fire", {
    achievement = core.colorize("#ff7755", "Oooo, Fire!"),
    colour = "#ffccaa"
})


core_1042.registry.register_material("1042_core:fire", {
    description = core_1042.lorelang.translate("Fire"),
    drawtype = "firelike",
    tiles = {
        {
            name = "1042_fire_animated.png",
            --name = "[combine:2x8:0,0=1042_plain_node.png\\^[colorize\\:#ff2200\\:128:0,2=1042_plain_node.png\\^[transformR90\\^[colorize\\:#ff3300\\:128:0,4=1042_plain_node.png\\^[transformR180\\^[colorize\\:#ff4400\\:128:0,6=1042_plain_node.png\\^[transformR270\\^[colorize\\:#ff3300\\:128",
            animation = {
                type = "vertical_frames",
                frames_w = 1,
                frames_h = 4,
                --aspect_w = 2,
                --aspect_h = 2,
                length = 0.5,
            }
        },
    },
    use_texture_alpha = "blend",

    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    floodable = true,
    buildable_to = false,

    drop = "",

    light_source = 8,
    damage_per_second = 5,
    
    groups = {breakable_by_hand = 3, burning = 1},

    item_type = "node",
}, 6, nil, nil)


-- Speacal nodes

core_1042.registry.register_material("1042_core:beryl", {
    description = core_1042.lorelang.translate("Beryl"),
    drawtype = "mesh",
    mesh = "crystal.obj",
    tiles = {"1042_beryl.png"},
    --tiles = {"1042_plain_node.png^[colorize:#66eecc:128"},
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

    item_type = "node",
}, 5, nil, nil)

core_1042.registry.register_material("1042_core:beryl_hanging", {
    description = core_1042.lorelang.translate("Hanging Beryl"),
    drawtype = "mesh",
    mesh = "crystal_roof.obj",
    tiles = {"1042_beryl.png"},
    --tiles = {"1042_plain_node.png^[colorize:#66eeee:128"},
    use_texture_alpha = "blend",

    paramtype = "light",
    paramtype2 = "4dir",
    sunlight_propagates = true,
    walkable = true,
    buildable_to = false,

    light_source = 5,
    
    groups = {breakable_by_hand = 3, attached_node = 4},

    item_type = "node",
}, 5, nil, nil)

core_1042.registry.register_material("1042_core:rock", {
    description = core_1042.lorelang.translate("Rock"),
    drawtype = "mesh",
    mesh = "rock.obj",
    tiles = {"1042_stone.png"},
    --tiles = {"1042_plain_node.png^[colorize:#777777:128"},
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

    groups = {breakable_by_hand = 3, attached_node = 3, rock = 1},

    item_type = "node",
}, 2, nil, nil)

core_1042.registry.register_material("1042_core:flint", {
    description = core_1042.lorelang.translate("Flint"),
    drawtype = "mesh",
    mesh = "flint.obj",
    tiles = {"1042_flint.png"},
    --tiles = {"1042_plain_node.png^[colorize:#07070d:128"},
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
        dug = {
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
    
    groups = {dig_immediate = 1, attached_node = 3, rock = 1},

    item_type = "node",
}, 1, nil, nil)

core_1042.registry.register_material("1042_core:torch", {
    description = core_1042.lorelang.translate("Torch"),
    drawtype = "nodebox",
    tiles = {"1042_torch_top.png", "1042_torch_side.png"},
    --tiles = {
    --    "1042_plain_node.png^[colorize:#ff9900:128",
    --    "1042_plain_node.png^[colorize:#371307:172"
    --},
    use_texture_alpha = "opaque",

    selection_box = {
        fixed = {
            {-0.1, -0.5, -0.1, 0.1, -0.1, 0.1},
            {-0.15, -0.1, -0.15, 0.15, 0.1, 0.15}
        }
    },
    collision_box = {
        fixed = {
            {-0.1, -0.5, -0.1, 0.1, -0.1, 0.1},
            {-0.15, -0.1, -0.15, 0.15, 0.1, 0.15}
        }
    },
    node_box = {
        type = "fixed",
        fixed = {
            {-0.1, -0.5, -0.1, 0.1, -0.1, 0.1},
            {-0.15, -0.1, -0.15, 0.15, 0.1, 0.15}
        }
    },

    paramtype2 = "4dir",

    paramtype = "light",
    light_source = 10,
    sunlight_propagates = true,
    walkable = false,
    buildable_to = false,
    
    groups = {dig_immediate = 1, attached_node = 3, burning = 1},

    item_type = "node",
}, nil, {
    result = "1042_core:torch",
    type = "1042_default",
    items = {
        "group:burns 5",
    }
}, nil)


core_1042.registry.register_material("1042_core:sticks", {
    description = core_1042.lorelang.translate("Sticks"),
    drawtype = "mesh",
    mesh = "sticks.obj",
    tiles = {"1042_sticks.png"},
    --tiles = {"1042_plain_node.png^[colorize:#672307:172"},
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
    
    groups = {dig_immediate = 1, attached_node = 3, burns = 1},

    item_type = "node",
}, 1, nil, {name = "1042_core:sticks", max_count = 32})


core_1042.registry.register_material("1042_core:iron_nugget", {
    description = core_1042.lorelang.translate("Iron Nugget"),
    drawtype = "mesh",
    mesh = "nugget.obj",
    tiles = {"1042_iron_nugget.png"},
    --tiles = {"1042_plain_node.png^[colorize:#551111:128"},
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
        dug = {
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

    _1042_moldable = {color = "#551111", name = "iron", drop = "1042_core:iron_ingot"},

    paramtype = "light",
    paramtype2 = "4dir",
    sunlight_propagates = true,
    walkable = true,
    buildable_to = false,
    
    groups = {dig_immediate = 1, attached_node = 3},

    item_type = "node",
}, 2, nil, {name = "1042_core:iron_nugget", max_count = 16})

core_1042.registry.register_material("1042_core:gold_nugget", {
    description = core_1042.lorelang.translate("Gold Nugget"),
    drawtype = "mesh",
    mesh = "nugget.obj",
    tiles = {"1042_gold_nugget.png"},
    --tiles = {"1042_plain_node.png^[colorize:#ddaa22:128"},
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
        dug = {
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

    _1042_moldable = {color = "#ddaa22", name = "gold", drop = "1042_core:gold_ingot"},

    paramtype = "light",
    paramtype2 = "4dir",
    sunlight_propagates = true,
    walkable = true,
    buildable_to = false,
    
    groups = {dig_immediate = 1, attached_node = 3},

    item_type = "node",
}, 2, nil, {name = "1042_core:gold_nugget", max_count = 8})


-- #fixme
core_1042.registry.register_material("1042_core:anvil", {
    description = core_1042.lorelang.translate("Anvil \n(WIP)"),
    drawtype = "mesh",
    mesh = "anvil.obj",
    tiles = {"1042_anvil.png"},
    --tiles = {"1042_plain_node.png^[colorize:#222222:128"},
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

    item_type = "node",
}, 3, nil, nil)


achievements_1042.register_achievement("smelter", {
    achievement = core.colorize("#ddcc55", "Smelter!"),
    colour = "#ffddaa"
})

core_1042.registry.register_material("1042_core:crude_iron", {
    description = core_1042.lorelang.translate("Crude Iron"),
    drawtype = "mesh",
    mesh = "flint.obj",
    tiles = {"1042_crude_iron.png"},
    --tiles = {"1042_plain_node.png^[colorize:#886666:200"},

    paramtype = "light",
    paramtype2 = "facedir",
    sunlight_propagates = true,
    walkable = true,
    buildable_to = false,

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

    item_type = "node",
}, 3, nil, {{name = "1042_core:crude_iron", max_count = 6}})


core_1042.registry.register_material("1042_core:iron_ingot", {
    description = core_1042.lorelang.translate("Iron Ingot"),
    drawtype = "nodebox",
    tiles = {"1042_iron_ingot.png"},
    --tiles = {"1042_plain_node.png^[colorize:#998888:200"},

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
        dug = {
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
    
    groups = {dig_immediate = 1, falling_node = 1},

    item_type = "node"
}, 3, nil, {name = "1042_core:iron_ingot", max_count = 6})


core_1042.registry.register_material("1042_core:candel", {
    description = core_1042.lorelang.translate("Candle"),
    drawtype = "mesh",
    mesh = "candel.obj",
    tiles = {"1042_candle_wax.png", "1042_candle_wick.png"},
    --tiles = {
    --    "1042_plain_node.png^[colorize:#aaaa88:200",
    --    "1042_plain_node.png^[colorize:#554444:200"
    --},

    paramtype = "light",
    paramtype2 = "facedir",
    sunlight_propagates = true,
    walkable = true,
    buildable_to = false,

    node_box = {
        type = "fixed",
        fixed = {-0.25, -0.5, -0.2, 0.25, -0.2, 0.25}
    },
    selection_box = {
        type = "fixed",
        fixed = {-0.25, -0.5, -0.2, 0.25, -0.2, 0.25}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.25, -0.5, -0.2, 0.25, -0.2, 0.25}
    },

    stack_max = 16,

    groups = {dig_immediate = 1, falling_node = 1},

    on_rightclick = function(pos, _, _, itemstack)
        if core.get_item_group(itemstack:get_name(), "burning") > 0 then
            core.set_node(pos, {name = "1042_core:candel_lit"})
        end
    end,

    item_type = "node"
}, 1, nil, {name = "1042_core:candel", max_count = 16})

core_1042.registry.register_material("1042_core:candel_lit", {
    description = core_1042.lorelang.translate("Lit Candle"),
    drawtype = "mesh",
    mesh = "candel.obj",
    tiles = {"1042_candle_wax.png", "1042_candle_flame.png"},
    --tiles = {
    --    "1042_plain_node.png^[colorize:#aaaa88:200",
    --    "1042_plain_node.png^[colorize:#bb9944:200"
    --},

    paramtype = "light",
    paramtype2 = "facedir",
    sunlight_propagates = true,
    walkable = true,
    buildable_to = false,

    light_source = 8,

    drop = "1042_core:candel",

    node_box = {
        type = "fixed",
        fixed = {-0.25, -0.5, -0.2, 0.25, -0.2, 0.25}
    },
    selection_box = {
        type = "fixed",
        fixed = {-0.25, -0.5, -0.2, 0.25, -0.2, 0.25}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.25, -0.5, -0.2, 0.25, -0.2, 0.25}
    },

    stack_max = 16,

    groups = {dig_immediate = 1, falling_node = 1},

    on_rightclick = function(pos)
        core.set_node(pos, {name = "1042_core:candel"})
    end,

    item_type = "node"
}, 1, nil, {})


core_1042.registry.register_material("1042_core:gold_ingot", {
    description = core_1042.lorelang.translate("Gold Ingot"),
    drawtype = "nodebox",
    tiles = {"1042_gold_ingot.png"},
    --tiles = {"1042_plain_node.png^[colorize:#ddaa00:200"},

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
        dug = {
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
    
    groups = {dig_immediate = 1, falling_node = 1},

    item_type = "node"
}, 3, nil, {name = "1042_core:gold_ingot", max_count = 6})


core_1042.registry.register_material("1042_core:pork_raw", {
    description = core_1042.lorelang.translate("Raw Pork"),
    drawtype = "mesh",
    mesh = "pork.obj",
    tiles = {"1042_pork_raw1.png", "1042_pork_raw1.png", "1042_pork_raw1.png"},
    --tiles = {
    --    "1042_plain_node.png^[colorize:#ffbb88:128",
    --    "1042_plain_node.png^[colorize:#ffaa77:144",
    --    "1042_plain_node.png^[colorize:#ff9966:128"
    --},
    use_texture_alpha = "opaque",

    paramtype = "light",
    paramtype2 = "facedir",
    sunlight_propagates = true,
    walkable = true,
    buildable_to = false,
    
    _1042_on_use = function(itemstack, user)
        return core_1042.eat(itemstack, user, 4, 2)
    end,

    _1042_cooks_to = "1042_core:pork_cooked",

    _1042_campfire_cooks = {
		hanging = true,
		name = "pork",
		drop = "1042_core:pork_cooked",
		model = "cooking_pork.obj",
		textures = {
			"1042_pork_cooking.png",
			"1042_pork_cooking.png",
			"1042_pork_cooking.png",
			"1042_pork_cooking.png"
		}
	},

    groups = {food = 1, dig_immediate = 1, attached_node = 3, cooks = 3},

    item_type = "node",
}, 2, nil, nil)

core_1042.registry.register_material("1042_core:pork_cooked", {
    description = core_1042.lorelang.translate("Cooked Pork"),
    drawtype = "mesh",
    mesh = "pork.obj",
    tiles = {"1042_pork_cooked.png", "1042_pork_cooked.png", "1042_pork_cooked.png"},
    --tiles = {
    --    "1042_plain_node.png^[colorize:#dd4422:128",
    --    "1042_plain_node.png^[colorize:#cc3311:144",
    --    "1042_plain_node.png^[colorize:#993322:128"
    --},
    use_texture_alpha = "opaque",

    paramtype = "light",
    paramtype2 = "facedir",
    sunlight_propagates = true,
    walkable = true,
    buildable_to = false,
    
    _1042_on_use = function(itemstack, user)
        return core_1042.eat(itemstack, user, 8, nil)
    end,


    groups = {food = 1, dig_immediate = 1, attached_node = 3},

    item_type = "node",
}, 2, nil, nil)