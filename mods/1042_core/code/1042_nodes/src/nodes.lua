
core.register_node("1042_core:node2", {
    description = "node2",
    tiles = {"1042_plain_node.png^[colorize:#aaaa88:168"},
    use_texture_alpha = "opaque",

    groups = {unbreakable = 1},
})




-- Universal nodes

core.register_node("1042_core:bedrock", {
    description = "Bedrock",
    tiles = {"1042_plain_node.png^[colorize:#110a02:200"},
    use_texture_alpha = "opaque",

    diggable = false,

    groups = {unbreakable = 1},
})

core.register_node("1042_core:skyrock", {
    description = "Skyrock",
    drawtype = "airlike",

    pointable = false,
    diggable = false,
    walkable = true,

    paramtype = "light",
    sunlight_propagates = true,

    groups = {unbreakable = 1, not_in_creative_inventory = 1},
})




-- Land Nodes

core.register_node("1042_core:dirt", {
    description = "Dirt",
    tiles = {"1042_plain_node.png^[colorize:#8b4513:128"},
    use_texture_alpha = "opaque",

    groups = {dirt = 1, breakable_by_hand = 3},
})

core.register_node("1042_core:sand", {
    description = "Sand",
    tiles = {"1042_plain_node.png^[colorize:#d9a357:128"},
    use_texture_alpha = "opaque",

    groups = {dirt = 1, falling_node = 1, breakable_by_hand = 3},
})

core.register_node("1042_core:ice", {
    description = "Ice",
    drawtype = "glasslike",
    tiles = {"ice.png"},
    use_texture_alpha = "blend",
	paramtype = "light",

    color = "#333333",

    _1042_melts_to = "1042_core:water_source",
    groups = {falling_node = 1, float = 1, melts = 1, slippery = 3, cools = 1, frozen = 1},
})

core.register_node("1042_core:turf", {
    description = "Turf",
    tiles = {"turf.png"},

    color = "#309913ff",
    paramtype2 = "color",
    palette = "turf_palette.png",
    node_placement_prediction = "",

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

    -- Add self as a drop to avoid meta
    drop = "",
    preserve_metadata = function(_, _, _, drops)
        drops[#drops+1] = ItemStack("1042_core:turf")
    end,

    groups = {dirt = 1, breakable_by_hand = 3, bio_mass = 8},
})

core.register_node("1042_core:snow", {
    description = "Snow",
    tiles = {"1042_plain_node.png^[colorize:#ffffff:168"},
    inventory_image = "snowflake1.png",
    wield_image = "snowflake1.png",
    wield_scale = {x = 0.5, y = 0.5, z = 0.5},
    use_texture_alpha = "opaque",
    drawtype = "nodebox",

	paramtype = "light",
    sunlight_propagates = true,

    floodable = true,

    paramtype2 = "leveled",
    leveled = 8,
    leveled_max = 64,
    node_placement_prediction = "",

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

    on_place = function(itemstack, placer, pointed_thing)
        if pointed_thing.type == "node" then
            local pos = pointed_thing.under
            local node = core.get_node(pos)
            if node.name == "1042_core:snow" then
                if core.get_node_level(pos) < core.get_node_max_level(pos) then
                    core.add_node_level(pos, 8)
                    return
                end
            end
        end

        core.item_place(itemstack, placer, pointed_thing)
    end,

    -- Add self as a drop to avoid meta
    drop = "",
    preserve_metadata = function(pos, _, _, drops)
        drops[#drops+1] = ItemStack("1042_core:snow " .. tostring((math.floor(core.get_node_level(pos) or 8)/8)))
    end,

    node_box = {
        type = "leveled",
        fixed = {
            -0.5, -0.5, -0.5,
            0.5, 0.0, 0.5
        }
    },

    _1042_melts_to = "1042_core:water_source",
    groups = {cools = 1, melts = 1, breakable_by_hand = 2},
})

core.register_node("1042_core:stone", {
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

core.register_node("1042_core:basalt", {
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
core_1042.register_loot({name = "1042_core:basalt"})

core.register_node("1042_core:iron_ore", {
    description = "Iron Ore",
    tiles = {"1042_plain_node.png^[colorize:#551111:128"},
    use_texture_alpha = "opaque",

    drop = {
        max_items = 5,
        items = {
            {
                rarity = 1,
                items = {"1042_core:iron_nugget"}
            },
            {
                rarity = 2,
                items = {"1042_core:iron_nugget"}
            },
            {
                rarity = 4,
                items = {"1042_core:iron_nugget"}
            },
            {
                rarity = 8,
                items = {"1042_core:rock"}
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
core_1042.register_loot({name = "1042_core:iron_ore"})




-- Charcoal


core.register_node("1042_core:charcoal", {
    description = "Charcoal",
    tiles = {"1042_plain_node.png^[colorize:#221111:168"},
    use_texture_alpha = "opaque",

    groups = {wood = 1, burns = 6, breakable_by_hand = 5},
})

core_1042.register_loot({name = "1042_core:charcoal"})

core.register_node("1042_core:charcoal_burning", {
    description = "Burning Charcoal",
    tiles = {"1042_plain_node.png^[colorize:#441111:168"},
    use_texture_alpha = "opaque",

    drop = "",

    light_source = 6,
    groups = {wood = 1, burning = 1, burns = 6, breakable_by_hand = 5},
})





-- Iron

core.register_node("1042_core:iron_slag", {
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

    groups = {stone = 3, breakable_by_hand = 4},
})



core.register_node("1042_core:iron_nugget_block", {
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

core_1042.crafting.register_craft({
    result = "1042_core:iron_nugget_block",
    type = "1042_default",
    items = {
        "1042_core:iron_nugget 9"
    }
})
core_1042.crafting.register_craft({
    result = "1042_core:iron_nugget 9",
    type = "1042_default",
    items = {
        "1042_core:iron_nugget_block"
    }
})





core.register_node("1042_core:chest", {
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

core_1042.crafting.register_craft({
    result = "1042_core:chest 2",
    type = "1042_default",
    items = {"1042_core:tree_dark 8"}
})