

-- Land Nodes

core.register_node("1042_nodes:bedrock", {
    description = "Bedrock",
    tiles = {"1042_plain_node.png^[colorize:#110a02:200"},
    use_texture_alpha = "opaque",

    groups = {unbreakable = 1},
})

core.register_node("1042_nodes:dirt", {
    description = "Dirt",
    tiles = {"1042_plain_node.png^[colorize:#8b4513:128"},
    use_texture_alpha = "opaque",

    groups = {dirt = 1, breakable_by_hand = 2},
})

core.register_node("1042_nodes:sand", {
    description = "Sand",
    tiles = {"1042_plain_node.png^[colorize:#d9a357:128"},
    use_texture_alpha = "opaque",

    groups = {dirt = 1, falling_node = 1, breakable_by_hand = 1},
})

core.register_node("1042_nodes:ice", {
    description = "Ice",
    drawtype = "glasslike",
    tiles = {"water.png"},
    use_texture_alpha = "blend",
	paramtype = "light",

    color = "#ee0000",

    _1042_melts_to = "1042_nodes:water_source",
    groups = {falling_node = 1, float = 1, melts = 1, slippery = 3, cools = 1, frozen = 1},
})

core.register_node("1042_nodes:turf", {
    description = "Turf",
    tiles = {"1042_plain_node.png"},
    use_texture_alpha = "opaque",

    paramtype2 = "color",
    palette = "turf_palette.png",

    sounds = {
        footstep = {
            name = "turf",
            gain = 0.8,
            pitch = 1.5
        },
        dig = {
            name = "turf",
            gain = 0.4,
            pitch = 1.5
        },
        place = {
            name = "turf",
            gain = 0.4,
            pitch = 1.5
        }
    },

    on_construct = function(pos)
        local node = core.get_node(pos)

        if node then
            node.param2 = weather.get_biome_palette_index(weather.get_temp_single(pos))
            core.swap_node(pos, node)
        end
    end,

    groups = {dirt = 1, breakable_by_hand = 1},
})

core.register_node("1042_nodes:snow", {
    description = "Snow",
    tiles = {"1042_plain_node.png^[colorize:#ffffff:168"},
    use_texture_alpha = "opaque",

    sounds = {
        footstep = {
            name = "turf",
            gain = 2,
            pitch = 2
        },
        dig = {
            name = "turf",
            gain = 1,
            pitch = 2
        },
        place = {
            name = "turf",
            gain = 1,
            pitch = 2
        }
    },

    _1042_melts_to = "1042_nodes:water_source",
    groups = {cools = 1, melts = 1, breakable_by_hand = 1},
})

core.register_node("1042_nodes:stone", {
    description = "Stone",
    tiles = {"1042_plain_node.png^[colorize:#777777:128"},
    use_texture_alpha = "opaque",

    sounds = {
        dig = {
            name = "stone_dig",
            gain = 2,
            pitch = 0.75
        },
        footstep = {
            name = "stone_walk",
            gain = 1,
            pitch = 1.25
        },
        place = {
            name = "stone_walk",
            gain = 1,
            pitch = 0.5
        }
    },

    groups = {stone = 1},
})

core.register_node("1042_nodes:basalt", {
    description = "Basalt",
    tiles = {"1042_plain_node.png^[colorize:#111111:128"},
    use_texture_alpha = "opaque",

    sounds = {
        dig = {
            name = "stone_dig",
            gain = 2,
            pitch = 0.6
        },
        footstep = {
            name = "stone_walk",
            gain = 1,
            pitch = 1
        },
        place = {
            name = "stone_walk",
            gain = 1,
            pitch = 0.5
        }
    },

    groups = {stone = 2},
})
core_1042.register_loot({name = "1042_nodes:basalt"})

core.register_node("1042_nodes:iron_ore", {
    description = "Iron Ore",
    tiles = {"1042_plain_node.png^[colorize:#551111:128"},
    use_texture_alpha = "opaque",

    drop = {
        max_items = 5,
        items = {
            {
                rarity = 1,
                items = {"1042_nodes:iron_nugget"}
            },
            {
                rarity = 2,
                items = {"1042_nodes:iron_nugget"}
            },
            {
                rarity = 4,
                items = {"1042_nodes:iron_nugget"}
            },
            {
                rarity = 8,
                items = {"1042_nodes:rock"}
            }
        }
    },

    sounds = {
        dig = {
            name = "stone_dig",
            gain = 2,
            pitch = 1
        },
        footstep = {
            name = "stone_walk",
            gain = 1,
            pitch = 1.5
        },
        place = {
            name = "stone_walk",
            gain = 1,
            pitch = 0.5
        }
    },

    groups = {stone = 3},
})
core_1042.register_loot({name = "1042_nodes:iron_ore"})

-- Plant Nodes


core.register_node("1042_nodes:leaves_plain", {
    description = "Leaves",
    tiles = {"1042_plain_node.png^[colorize:#1c770a:168"},
    use_texture_alpha = "blend",
    drawtype = "allfaces",
    
    paramtype = "light",
    sunlight_propagates = true,

    groups = {leafy = 1, plant = 1, breakable_by_hand = 1, burns = 1},
})

core.register_node("1042_nodes:leaves_light", {
    description = "Light leaves",
    tiles = {"1042_plain_node.png^[colorize:#99cc99:168"},
    use_texture_alpha = "blend",
    drawtype = "allfaces",
    
    paramtype = "light",
    sunlight_propagates = true,

    groups = {leafy = 1, plant = 1, breakable_by_hand = 1, burns = 1},
})


core.register_node("1042_nodes:leaves_dark", {
    description = "Dark Leaves",
    tiles = {"1042_plain_node.png^[colorize:#1f470a:168"},
    use_texture_alpha = "blend",
    drawtype = "allfaces",
    
    paramtype = "light",
    sunlight_propagates = true,

    groups = {leafy = 1, plant = 1, breakable_by_hand = 1, burns = 1},
})


core.register_node("1042_nodes:tree", {
    description = "Tree",
    tiles = {"1042_plain_node.png^[colorize:#672307:200"},
    use_texture_alpha = "opaque",

    sounds = {
        dig = {
            name = "tree_dig",
            gain = 2,
            pitch = 1
        }
    },

    groups = {wood = 1, plant = 1, burns = 3},
})

core.register_node("1042_nodes:tree_dark", {
    description = "Dark Tree",
    tiles = {"1042_plain_node.png^[colorize:#371307:200"},
    use_texture_alpha = "opaque",

    sounds = {
        dig = {
            name = "tree_dig",
            gain = 2,
            pitch = 0.75
        }
    },

    groups = {wood = 2, plant = 1, burns = 4},
})

core.register_node("1042_nodes:tree_light", {
    description = "Light Tree",
    tiles = {"1042_plain_node.png^[colorize:#676357:200"},
    use_texture_alpha = "opaque",

    sounds = {
        dig = {
            name = "tree_dig",
            gain = 2,
            pitch = 1.5
        }
    },

    groups = {wood = 1, plant = 1, burns = 2},
})









-- Charcoal


core.register_node("1042_nodes:charcoal", {
    description = "Charcoal",
    tiles = {"1042_plain_node.png^[colorize:#221111:168"},
    use_texture_alpha = "opaque",

    groups = {wood = 1, burns = 6, breakable_by_hand = 4},
})

core_1042.register_loot({name = "1042_nodes:charcoal"})

core.register_node("1042_nodes:charcoal_burning", {
    description = "Burning Charcoal",
    tiles = {"1042_plain_node.png^[colorize:#441111:168"},
    use_texture_alpha = "opaque",

    drop = "",

    light_source = 6,
    groups = {wood = 1, burning = 1, burns = 6, breakable_by_hand = 4},
})





-- Iron

core.register_node("1042_nodes:iron_slag", {
    description = "Iron Slag",
    tiles = {"1042_plain_node.png^[colorize:#331111:128"},
    use_texture_alpha = "opaque",

    sounds = {
        dig = {
            name = "stone_dig",
            gain = 2,
            pitch = 0.3
        },
        footstep = {
            name = "stone_walk",
            gain = 1,
            pitch = 0.5
        },
        place = {
            name = "stone_walk",
            gain = 0.5,
            pitch = 0.5
        }
    },

    groups = {stone = 3, breakable_by_hand = 3},
})



core.register_node("1042_nodes:iron_nugget_block", {
    description = "Iron Nugget Block",
    tiles = {"1042_plain_node.png^[colorize:#664444:128"},
    use_texture_alpha = "opaque",

    sounds = {
        dig = {
            name = "stone_dig",
            gain = 2,
            pitch = 1
        },
        footstep = {
            name = "stone_walk",
            gain = 1,
            pitch = 1.5
        },
        place = {
            name = "stone_walk",
            gain = 1,
            pitch = 0.5
        }
    },

    groups = {stone = 3},
})

core.register_craft({
    output = "1042_nodes:iron_nugget_block",
    recipe = {
        {"1042_nodes:iron_nugget", "1042_nodes:iron_nugget", "1042_nodes:iron_nugget"},
        {"1042_nodes:iron_nugget", "1042_nodes:iron_nugget", "1042_nodes:iron_nugget"},
        {"1042_nodes:iron_nugget", "1042_nodes:iron_nugget", "1042_nodes:iron_nugget"},
    }
})







core.register_node("1042_nodes:chest", {
    description = "Chest",
    drawtype = "mesh",
    mesh = "chest.obj",
    tiles = {
        "1042_plain_node.png^[colorize:#572307:200", 
        "1042_plain_node.png^[colorize:#bbaa37:200"
    },
    
    paramtype2 = "4dir",
    paramtype = "light",
    sunlight_propagates = true,

    sounds = {
        dig = {
            name = "tree_dig",
            gain = 2,
            pitch = 1
        }
    },

    on_construct = function(pos)
        local meta = core.get_meta(pos)
        local inv = meta:get_inventory()

        inv:set_size("main", 10)

        meta:set_string("formspec",
            "formspec_version[8]size[14,9,false]"..
            "list[context;main;1,1;10,1;]"..
            "list[current_player;main;1,3;10,4;]"..
            "listring[current_player;main]"..
            "listring[context;main]"
        )

        meta:set_string("init", "true")
    end,

    on_rightclick = function(pos, node, player, itemstack, pointed_thing)
        local meta = core.get_meta(pos)
        
        if meta:get_string("init") ~= "true" then 
            local inv = meta:get_inventory()
    
            inv:set_size("main", 10)
    
            meta:set_string("formspec",
                "formspec_version[8]size[14,9,false]"..
                "list[context;main;1,1;10,1;]"..
                "list[current_player;main;1,3;10,4;]"..
                "listring[current_player;main]"..
                "listring[context;main]"
            )

            meta:set_string("init", "true")

            for i = 1, 10 do
                if core_1042.rand:next(1, 4) == 1 then
                    inv:set_stack("main", i, core_1042.get_loot())
                end
            end

            core.chat_send_player(player:get_player_name(), core.colorize("#00ff00", "Chest unlocked!"))
            return
        end

        core.show_formspec(player:get_player_name(), "chest_inv", core.get_meta(pos):get_string("formspec"))
    end,

    groups = {wood = 1},
})

core.register_craft({
    output = "1042_nodes:chest 2",
    recipe = {
        {"group:wood", "group:wood", "group:wood"},
        {"group:wood", "", "group:wood"},
        {"group:wood", "group:wood", "group:wood"}
    }
})