
core.register_node("1042_core:node2", {
    description = core_1042.lorelang.translate("Sky Stone"),
    tiles = {"1042_sky_stone.png"}, --^[colorize:#aaaa77:128
    groups = {unbreakable = 1},
})


core_1042.registry.register_material("1042_core:dev", {
    description = core_1042.lorelang.translate("Dev"),
    tiles = {"1042_bedrock.png"},

    diggable = true,

    _1042_aux = {
        horizontal = true,
        bar_params = {
            image = "1042_plain_node.png^[colorize:#00ffff:128^[opacity:64",
            selected_image = "1042_plain_node.png^[colorize:#00ffff:128^[opacity:128"
        },
        mode = "selection",
        num = 16,
    },

    groups = {dig_immediate = 1},
}, 6, nil, nil)

-- Universal nodes

core_1042.registry.register_material("1042_core:bedrock", {
    description = core_1042.lorelang.translate("Bedrock"),
    tiles = {"1042_bedrock.png"},
    --tiles = {"1042_plain_node.png^[colorize:#110a02:200"},
    --use_texture_alpha = "opaque",

    _mg_name = "bedrock",

    diggable = false,

    groups = {unbreakable = 1},
}, 6, nil, nil)

core.register_node("1042_core:skyrock", {
    description = core_1042.lorelang.translate("Sky Rock"),
    drawtype = "airlike",

    _mg_name = "skyrock",

    pointable = false,
    diggable = false,
    walkable = true,

    paramtype = "light",
    sunlight_propagates = true,

    groups = {unbreakable = 1, not_in_creative_inventory = 1},
})

core_1042.registry.register_material("1042_core:white", {
    description = core_1042.lorelang.translate("White"),
    tiles = {"1042_plain_node.png^[colorize:#ffffff:255"},
    use_texture_alpha = "opaque",

    diggable = false,

    groups = {unbreakable = 1},
}, 6, nil, nil)

core_1042.registry.register_material("1042_core:black", {
    description = core_1042.lorelang.translate("Black"),
    tiles = {"1042_plain_node.png^[colorize:#000000:255"},
    use_texture_alpha = "opaque",

    diggable = false,

    groups = {unbreakable = 1},
}, 6, nil, nil)


-- Dimensional

core.register_node("1042_core:sky_portal", {
    description = core_1042.lorelang.translate("Sky Portal"),
    tiles = {{
        name = "1042_sky_portal.png",
        --name = "1042_plain_node.png^[colorize:#002228:128",
        backface_culling = true,
        animation = {
            type = "sheet_2d",
            frames_w = 1,
            frames_h = 4,
            frame_length = 0.2,
        }
    }},
    drawtype = "glasslike",
    use_texture_alpha = "blend",
    paramtype = "light",

    diggable = false,
    walkable = false,

    light_source = 14,

    on_punch = function(_, _, clicker, _, _)
        local sound = core.sound_play("water", {
            loop = true,
            to_player = clicker:get_player_name(),
            gain = 0,
            pitch = 0.1
        })
        core.sound_fade(sound, 0.25, 6)
        core.emerge_area(vector.new(0, 2046, 0), vector.new(0, 2048, 0), function()
            core.set_node(vector.new(0, 2046, 0), {name = "1042_core:bedrock"})
            core.set_node(vector.new(0, 2047, 0), {name = "air"})
            core.set_node(vector.new(0, 2048, 0), {name = "air"})
            clicker:set_pos(vector.new(0, 2048, 0))

            core.sound_fade(sound, 0.1, 0)
        end)
    end,

    groups = {unbreakable = 1},
})


-- Land Nodes

core.register_node("1042_core:dirt", {
    description = core_1042.lorelang.translate("Dirt"),
    tiles = {"1042_dirt.png"},
    groups = {soil = 1, breakable_by_hand = 3},
})

core.register_node("1042_core:mud", {
    description = core_1042.lorelang.translate("Mud"),
    tiles = {"1042_mud.png"},
    groups = {soil = 1, breakable_by_hand = 3},
})

core.register_node("1042_core:sulfur_mud", {
    description = core_1042.lorelang.translate("Sulfur Mud"),
    tiles = {"1042_sulfur_mud.png"},
    groups = {soil = 1, breakable_by_hand = 3},
})

core.register_node("1042_core:bubbling_sulfur_mud", {
    description = core_1042.lorelang.translate("Bubbling Sulfur Mud"),
    tiles = {{
        name = "1042_bubbling_sulfur_mud.png",
        animation = {
            type = "sheet_2d",
            frames_w = 1,
            frames_h = 4,
            frame_length = 0.2,
        }
    }},
    drop = "1042_core:sulfur_mud",
    groups = {soil = 1, breakable_by_hand = 3},
})


core.register_node("1042_core:silt", {
    description = core_1042.lorelang.translate("Silt"),
    tiles = {"1042_silt.png"},
    groups = {soil = 1, breakable_by_hand = 3},
})

core.register_node("1042_core:clay", {
    description = core_1042.lorelang.translate("Clay"),
    tiles = {"1042_clay.png"},
    groups = {soil = 1, breakable_by_hand = 3},
})

core.register_node("1042_core:sand", {
    description = core_1042.lorelang.translate("Sand"),
    tiles = {"1042_sand.png"},
    groups = {soil = 1, falling_node = 1, breakable_by_hand = 3},
})

core.register_node("1042_core:burning_sand", {
    description = core_1042.lorelang.translate("Burning Sand"),
    tiles = {"1042_burning_sand.png"},
    groups = {soil = 1, falling_node = 1, breakable_by_hand = 3},
})

core.register_node("1042_core:scorched_sand", {
    description = core_1042.lorelang.translate("Scorched Sand"),
    tiles = {"1042_scorched_sand.png"},
    groups = {soil = 1, falling_node = 1, breakable_by_hand = 2},
})

core.register_node("1042_core:wet_sand", {
    description = core_1042.lorelang.translate("Wet Sand"),
    tiles = {"1042_wet_sand.png"},
    groups = {soil = 1, falling_node = 1, breakable_by_hand = 2},
})

core.register_node("1042_core:frozen_sand", {
    description = core_1042.lorelang.translate("Frozen Sand"),
    tiles = {"1042_frozen_sand.png"},
    groups = {soil = 1, cools = 1, breakable_by_hand = 2},
})

core.register_node("1042_core:weathered_sand", {
    description = core_1042.lorelang.translate("Weathered Sand"),
    tiles = {"1042_weathered_sand.png"},
    groups = {soil = 1, falling_node = 1, breakable_by_hand = 3},
})

core.register_node("1042_core:sandstone", {
    description = core_1042.lorelang.translate("Sandstone"),
    tiles = {"1042_sandstone.png"},
    groups = {stone = 1, breakable_by_hand = 1},
})

core.register_node("1042_core:mudstone", {
    description = core_1042.lorelang.translate("mudstone"),
    tiles = {"1042_mudstone.png"},
    groups = {stone = 1, breakable_by_hand = 1},
})

core.register_node("1042_core:limestone", {
    description = core_1042.lorelang.translate("Limestone"),
    tiles = {"1042_limestone.png"},
    _mg_name = "limestone",
    groups = {stone = 1},
})

core.register_node("1042_core:pumice", {
    description = core_1042.lorelang.translate("Pumice"),
    tiles = {"1042_pumice.png"},
    _mg_name = "pumice",
    groups = {stone = 1},
})

core.register_node("1042_core:cinder", {
    description = core_1042.lorelang.translate("Scoria"),
    tiles = {"1042_cinder.png"},
    groups = {stone = 1},
})

core.register_node("1042_core:gusher_spout", {
    description = core_1042.lorelang.translate("Gusher Spout"),
    tiles = {
        "1042_limestone.png^1042_gusher_spout.png",
        "1042_limestone.png"
    },
    _mg_name = "gusher_spout",
    groups = {stone = 1},
})

core.register_node("1042_core:geyser_nozzle", {
    description = core_1042.lorelang.translate("Geyser Nozzle"),
    tiles = {
        "1042_limestone.png^1042_geyser_nozzle.png",
        "1042_limestone.png"
    },
    _mg_name = "geyser_nozzle",
    groups = {stone = 1},
})

core.register_node("1042_core:permafrost", {
    description = core_1042.lorelang.translate("Permafrost"),
    tiles = {"1042_permafrost.png"},
    groups = {stone = 1, cools = 1},
})

core.register_node("1042_core:glass", {
    description = core_1042.lorelang.translate("Glass"),
    drawtype = "glasslike",
    --tiles = {"1042_plain_node.png"},
    tiles = {"1042_glass.png"},
    use_texture_alpha = "blend",
	paramtype = "light",

    groups = {stone=3, slippery = 1},
})

core.register_node("1042_core:leaf_litter", {
    description = core_1042.lorelang.translate("Leaf Litter"),
    tiles = {"1042_dirt.png^1042_leaf_litter.png"},
    sounds = {
        footstep = {
            name = "turf",
            gain = 0.8,
            pitch = 0.75
        },
        dig = {
            name = "turf",
            gain = 0.4,
            pitch = 0.75
        },
        place = {
            name = "turf",
            gain = 0.4,
            pitch = 0.75
        }
    },

    groups = {breakable_by_hand = 2, bio_mass = 8},
})

core.register_node("1042_core:moss", {
    description = core_1042.lorelang.translate("Moss"),
    tiles = {"1042_moss.png"},

    --color = "#309913ff",
    node_placement_prediction = "",

    sounds = {
        footstep = {
            name = "turf",
            gain = 0.8,
            pitch = 0.75
        },
        dig = {
            name = "turf",
            gain = 0.4,
            pitch = 0.75
        },
        place = {
            name = "turf",
            gain = 0.4,
            pitch = 0.75
        }
    },

    groups = {breakable_by_hand = 2, bio_mass = 8},
})

core.register_node("1042_core:ice", {
    description = core_1042.lorelang.translate("Ice"),
    drawtype = "glasslike",
    tiles = {"1042_ice.png"},
    use_texture_alpha = "blend",
	paramtype = "light",

    --color = "#333333",

    _1042_melts_to = "1042_core:water_source",
    groups = {falling_node = 1, float = 1, melts = 1, slippery = 3, cools = 1, frozen = 1},
})

core.register_node("1042_core:turf", {
    description = core_1042.lorelang.translate("Turf"),
    tiles = {"1042_turf.png"},

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
            node.param2 = weather.get_biome_palette_index(weather.get_temp_single(pos), weather.get_humidity_single(pos))
            core.swap_node(pos, node)
        end
    end,

    -- Add self as a drop to avoid meta
    drop = "",
    preserve_metadata = function(_, _, _, drops)
        drops[#drops+1] = ItemStack("1042_core:turf")
    end,

    groups = {soil = 1, breakable_by_hand = 3, bio_mass = 8},
})

core.register_node("1042_core:turf_tilled", {
    description = core_1042.lorelang.translate("Tilled Turf"),
    --tiles = {"turf.png^[colorize:#000000:128"},
    tiles = {"1042_turf_tilled.png"},
    color = "#664413ff",
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
            node.param2 = weather.get_biome_palette_index(weather.get_temp_single(pos), weather.get_humidity_single(pos))
            core.swap_node(pos, node)
        end
    end,

    -- Add self as a drop to avoid meta
    drop = "",
    preserve_metadata = function(_, _, _, drops)
        drops[#drops+1] = ItemStack("1042_core:turf")
    end,

    groups = {soil = 1, breakable_by_hand = 3, bio_mass = 8},
})


core_1042.crafting.register_craft({
    node = "1042_core:turf",
    type = "1042_tilling",
    result = "1042_core:turf_tilled"
})

core.register_node("1042_core:snow", {
    description = core_1042.lorelang.translate("Snow"),
    --tiles = {"1042_plain_node.png^[colorize:#ffffff:168"},
    tiles = {"1042_snow.png"},
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
    description = core_1042.lorelang.translate("Stone"),
    --tiles = {"1042_plain_node.png^[colorize:#777777:128"},
    tiles = {"1042_stone.png"},
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
    description = core_1042.lorelang.translate("Basalt"),
    tiles = {"1042_basalt.png"},
    --tiles = {"1042_plain_node.png^[colorize:#111111:200"},
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

local function register_ore(name)
    core.register_node("1042_core:"..name.."_ore", {
        description = core_1042.lorelang.translate(name:gsub("^%l", string.upper) .. " Ore"),
        tiles = {"1042_stone.png^1042_"..name.."_ore.png"},
        --tiles = {"1042_plain_node.png^[colorize:#551111:128"},
        use_texture_alpha = "opaque",
    
        drop = {
            max_items = 5,
            items = {
                {
                    rarity = 1,
                    items = {"1042_core:"..name.."_nugget"}
                },
                {
                    rarity = 2,
                    items = {"1042_core:"..name.."_nugget"}
                },
                {
                    rarity = 4,
                    items = {"1042_core:"..name.."_nugget"}
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
    core_1042.register_loot({name = "1042_core:"..name.."_ore"})
end

register_ore("copper")
register_ore("iron")
register_ore("gold")
register_ore("silver")
register_ore("cobalt")
register_ore("titanium")


-- Charcoal


core.register_node("1042_core:charcoal", {
    description = core_1042.lorelang.translate("Charcoal"),
    tiles = {"1042_charcoal.png"},
    --tiles = {"1042_plain_node.png^[colorize:#221111:168"},
    use_texture_alpha = "opaque",

    groups = {wood = 1, burns = 6, breakable_by_hand = 5},
})

core_1042.register_loot({name = "1042_core:charcoal"})

core.register_node("1042_core:charcoal_burning", {
    description = core_1042.lorelang.translate("Burning Charcoal"),
    tiles = {"1042_charcoal_burning.png"},
    --tiles = {"1042_plain_node.png^[colorize:#441111:168"},
    use_texture_alpha = "opaque",

    drop = "",

    light_source = 6,
    groups = {wood = 1, burning = 1, burns = 6, breakable_by_hand = 5},
})





-- Iron

core.register_node("1042_core:iron_slag", {
    description = core_1042.lorelang.translate("Iron Slag"),
    tiles = {"1042_iron_slag.png"},
    --tiles = {"1042_plain_node.png^[colorize:#331111:128"},
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
    description = core_1042.lorelang.translate("Iron Nugget Block"),
    tiles = {"1042_iron_nugget_block.png"},
    --tiles = {"1042_plain_node.png^[colorize:#664444:128"},
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
    description = core_1042.lorelang.translate("Chest"),
    drawtype = "mesh",
    mesh = "chest.obj",
    tiles = {
        "1042_iron_ingot.png",
        "1042_chest.png",
        "1042_chest_lock.png",
        "1042_iron_ingot.png",
        "1042_chest.png"
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