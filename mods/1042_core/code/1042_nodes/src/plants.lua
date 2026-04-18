

-- Plants


-- Grasses are an extension of turf

local c = core.colorize


core.register_node("1042_core:mushroom", {
    description = core_1042.lorelang.translate("Mushroom"),
    drawtype = "mesh",
    mesh = "mushroom.obj",
    tiles = {"1042_mushroom_brown.png", "1042_mushroom_stem.png"},
    use_texture_alpha = "opaque",

    node_box = {
        type = "fixed",
        fixed = {-0.4, -0.5, -0.4, 0.4, 0.2, 0.4}
    },
    selection_box = {
        type = "fixed",
        fixed = {-0.4, -0.5, -0.4, 0.4, 0.2, 0.4}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.4, -0.5, -0.4, 0.4, 0.2, 0.4}
    },

    paramtype = "light",
    paramtype2 = "wallmounted",
    node_placement_prediction = "",

    sunlight_propagates = true,
    floodable = true,
    walkable = false,
    buildable_to = false,

    _1042_on_use = function(itemstack, user, pointed_thing)
        return core_1042.eat(itemstack, user, 2, 10)
    end,

    groups = {plant = 1, attached_node = 1, dig_immediate = 1, burns = 1, growth = 1, growth_bio_mass = 4, bio_mass = 1}, -- #fixme Add growth, and biomater types to docs
})

core.register_node("1042_core:apple", {
    description = core_1042.lorelang.translate("Apple"),
    drawtype = "mesh",
    mesh = "fruit.obj",
    tiles = {"1042_apple.png"},
    use_texture_alpha = "opaque",

    paramtype = "light",
    sunlight_propagates = true,
    walkable = true,
    buildable_to = false,
    
    _1042_on_use = function(itemstack, user, pointed_thing)
        return core_1042.eat(itemstack, user, 3, nil)
    end,

    groups = {plant = 1, food = 1, dig_immediate = 1},
})


-- Flowers

core.register_node("1042_core:light_bloom", {
    description = core_1042.lorelang.translate("Light Bloom"),
    drawtype = "mesh",
    mesh = "flower_1.obj",
    tiles = {
        "1042_plain_node.png^[colorize:#178b03:128", -- stem
        "1042_plain_node.png^[colorize:#110099:64", -- petal
        "1042_plain_node.png^[colorize:#077b03:128"  -- leaf
    },
    use_texture_alpha = "opaque",

    paramtype = "light",
    light_source = 4,
    sunlight_propagates = true,
    floodable = true,
    walkable = false,
    buildable_to = false,

    groups = {plant = 1, attached_node = 3, dig_immediate = 1, burns = 1, flower = 1},
})

core.register_node("1042_core:digitalis", {
    description = core_1042.lorelang.translate("Digitalis"),
    drawtype = "mesh",
    mesh = "digitalis.obj",
    tiles = {
        "1042_flower2_stem.png",
        "1042_flower2_petal.png"
    },
    use_texture_alpha = "opaque",

    paramtype = "light",
    sunlight_propagates = true,
    floodable = true,
    walkable = false,
    buildable_to = false,

    sounds = {
        dug = {
            name = "turf",
            gain = 0.8,
            pitch = 3
        },
        place = {
            name = "turf",
            gain = 0.8,
            pitch = 2
        }
    },

    _1042_on_use = function(itemstack, user, pointed_thing)
        return core_1042.eat(itemstack, user, 9, 1)
    end,

    groups = {plant = 1, attached_node = 3, dig_immediate = 1, burns = 1, flower = 2},
})

core.register_node("1042_core:tulip", {
    description = core_1042.lorelang.translate("Tulip"),
    drawtype = "mesh",
    mesh = "flower_3.obj",
    tiles = {
        "1042_flower3_stem.png",
        "1042_flower3_petal.png",
        "1042_flower3_leaf.png"
    },
    use_texture_alpha = "opaque",

    paramtype = "light",
    sunlight_propagates = true,
    floodable = true,
    walkable = false,
    buildable_to = false,

    groups = {plant = 1, attached_node = 3, dig_immediate = 1, burns = 1, flower = 3},
})

core.register_node("1042_core:grass_mid", {
    description = core_1042.lorelang.translate("Grass"),
    drawtype = "plantlike",
    tiles = {"1042_grass_mid.png"},
    use_texture_alpha = "clip",

    paramtype = "light",
    sunlight_propagates = true,
    floodable = true,
    walkable = false,
    buildable_to = false,

    color = "#309913ff",
    paramtype2 = "color",
    palette = "turf_palette.png",
    node_placement_prediction = "",

    sounds = {
        dug = {
            name = "turf",
            gain = 0.4,
            pitch = 1.7
        },
        place = {
            name = "turf",
            gain = 0.4,
            pitch = 1.7
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
        drops[#drops+1] = ItemStack("1042_core:grass_mid")
    end,

    groups = {plant = 1, attached_node = 3, dig_immediate = 1, burns = 1},
})

core.register_node("1042_core:grass_tall", {
    description = core_1042.lorelang.translate("Tall Grass"),
    drawtype = "plantlike",
    tiles = {"1042_grass_tall.png"},
    use_texture_alpha = "clip",

    paramtype = "light",
    sunlight_propagates = true,
    floodable = true,
    walkable = false,
    buildable_to = false,

    color = "#309913ff",
    paramtype2 = "color",
    palette = "turf_palette.png",
    node_placement_prediction = "",

    sounds = {
        dug = {
            name = "turf",
            gain = 0.4,
            pitch = 1.7
        },
        place = {
            name = "turf",
            gain = 0.4,
            pitch = 1.7
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
        drops[#drops+1] = ItemStack("1042_core:grass_tall")
    end,

    groups = {plant = 1, attached_node = 3, dig_immediate = 1, burns = 1},
})

core.register_node("1042_core:grass_short", {
    description = core_1042.lorelang.translate("Short Grass"),
    drawtype = "plantlike",
    tiles = {"1042_grass_short.png"},
    use_texture_alpha = "clip",

    paramtype = "light",
    sunlight_propagates = true,
    floodable = true,
    walkable = false,
    buildable_to = false,

    color = "#309913ff",
    paramtype2 = "color",
    palette = "turf_palette.png",
    node_placement_prediction = "",

    sounds = {
        dug = {
            name = "turf",
            gain = 0.4,
            pitch = 1.7
        },
        place = {
            name = "turf",
            gain = 0.4,
            pitch = 1.7
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
        drops[#drops+1] = ItemStack("1042_core:grass_short")
    end,

    groups = {plant = 1, attached_node = 3, dig_immediate = 1, burns = 1},
})

core.register_node("1042_core:grass_thin", {
    description = core_1042.lorelang.translate("Thin Grass"),
    drawtype = "plantlike",
    tiles = {"1042_grass_thin.png"},
    use_texture_alpha = "clip",

    paramtype = "light",
    sunlight_propagates = true,
    floodable = true,
    walkable = false,
    buildable_to = false,

    color = "#309913ff",
    paramtype2 = "color",
    palette = "turf_palette.png",
    node_placement_prediction = "",

    sounds = {
        dug = {
            name = "turf",
            gain = 0.4,
            pitch = 1.7
        },
        place = {
            name = "turf",
            gain = 0.4,
            pitch = 1.7
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
        drops[#drops+1] = ItemStack("1042_core:grass_thin")
    end,

    groups = {plant = 1, attached_node = 3, dig_immediate = 1, burns = 1},
})

core.register_node("1042_core:sunflower", {
    description = core_1042.lorelang.translate("Sunflower"),
    drawtype = "mesh",
    mesh = "flower_4.obj",
    tiles = {
        "1042_flower4_stem.png",
        "1042_flower4_petal.png",
        "1042_flower4_leaf.png"
    },
    use_texture_alpha = "opaque",

    paramtype = "light",
    paramtype2 = "4dir",
    sunlight_propagates = true,
    floodable = true,
    walkable = false,
    buildable_to = false,

    groups = {plant = 1, attached_node = 3, dig_immediate = 1, burns = 1, flower = 4},
})


core.register_node("1042_core:cave_grass", {
    description = core_1042.lorelang.translate("Cave Grass"),
    drawtype = "plantlike",
    tiles = {"1042_cave_grass.png"},
    use_texture_alpha = "clip",

    paramtype = "light",
    sunlight_propagates = true,
    floodable = true,
    walkable = false,
    buildable_to = false,

    sounds = {
        dug = {
            name = "turf",
            gain = 0.4,
            pitch = 1.7
        },
        place = {
            name = "turf",
            gain = 0.4,
            pitch = 1.7
        }
    },

    paramtype2 = "meshoptions",
    place_param2 = 16 + 32 + 4,

    groups = {plant = 1, attached_node = 3, dig_immediate = 1, burns = 1},
})

core.register_node("1042_core:thin_moss", {
    description = core_1042.lorelang.translate("Thin Moss"),
    drawtype = "signlike",

    tiles = {"1042_thin_moss.png"},
    use_texture_alpha = "clip",
    paramtype2 = "wallmounted",
    paramtype = "light",
    sunlight_propagates = true,
    floodable = true,
    walkable = false,
    buildable_to = false,

    sounds = {
        dug = {
            name = "turf",
            gain = 0.4,
            pitch = 1.7
        },
        place = {
            name = "turf",
            gain = 0.4,
            pitch = 1.7
        }
    },

    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, -0.45, 0.5}
    },

    groups = {plant = 1, attached_node = 1, dig_immediate = 1, burns = 1},
})

core.register_node("1042_core:clover", {
    description = core_1042.lorelang.translate("Clover"),
    drawtype = "plantlike",
    tiles = {"1042_clover.png"},
    use_texture_alpha = "clip",

    paramtype = "light",
    sunlight_propagates = true,
    floodable = true,
    walkable = false,

    sounds = {
        dug = {
            name = "turf",
            gain = 0.4,
            pitch = 1.7
        },
        place = {
            name = "turf",
            gain = 0.4,
            pitch = 1.7
        }
    },

    _1042_on_use = function(itemstack, user, pointed_thing)
        return core_1042.eat(itemstack, user, 1, 15)
    end,

    groups = {plant = 1, attached_node = 3, dig_immediate = 1, flower = 5},
})

core.register_node("1042_core:thistles", {
    description = core_1042.lorelang.translate("Thistles"),
    drawtype = "plantlike",
    tiles = {"1042_thistles.png"},
    use_texture_alpha = "clip",

    paramtype = "light",
    sunlight_propagates = true,
    floodable = true,
    walkable = false,

    sounds = {
        dug = {
            name = "turf",
            gain = 0.4,
            pitch = 1.7
        },
        place = {
            name = "turf",
            gain = 0.4,
            pitch = 1.7
        }
    },

    _1042_on_use = function(itemstack, user, pointed_thing)
        return core_1042.eat(itemstack, user, 1, 2)
    end,

    groups = {plant = 1, attached_node = 3, dig_immediate = 1, flower = 6},
})

core.register_node("1042_core:honeysuckle", {
    description = core_1042.lorelang.translate("Honeysuckle"),
    drawtype = "plantlike",
    tiles = {"1042_honeysuckle.png"},
    use_texture_alpha = "clip",

    paramtype = "light",
    sunlight_propagates = true,
    floodable = true,
    walkable = false,

    sounds = {
        dug = {
            name = "turf",
            gain = 0.4,
            pitch = 1.7
        },
        place = {
            name = "turf",
            gain = 0.4,
            pitch = 1.7
        }
    },

    _1042_on_use = function(itemstack, user, pointed_thing)
        return core_1042.eat(itemstack, user, 1, 15)
    end,

    groups = {plant = 1, attached_node = 3, dig_immediate = 1, flower = 7},
})

core.register_node("1042_core:raspberries", {
    description = core_1042.lorelang.translate("Raspberries"),
    drawtype = "plantlike",
    tiles = {"1042_raspberries.png"},
    use_texture_alpha = "clip",

    paramtype = "light",
    sunlight_propagates = true,
    floodable = true,
    walkable = false,

    sounds = {
        dug = {
            name = "turf",
            gain = 0.4,
            pitch = 1.7
        },
        place = {
            name = "turf",
            gain = 0.4,
            pitch = 1.7
        }
    },

    _1042_on_use = function(itemstack, user, pointed_thing)
        return core_1042.eat(itemstack, user, 2, 15)
    end,

    groups = {plant = 1, attached_node = 3, dig_immediate = 1},
})

core.register_node("1042_core:blackberries", {
    description = core_1042.lorelang.translate("Blackberries"),
    drawtype = "plantlike",
    tiles = {"1042_blackberries.png"},
    use_texture_alpha = "clip",

    paramtype = "light",
    sunlight_propagates = true,
    floodable = true,
    walkable = false,

    sounds = {
        dug = {
            name = "turf",
            gain = 0.4,
            pitch = 1.7
        },
        place = {
            name = "turf",
            gain = 0.4,
            pitch = 1.7
        }
    },

    _1042_on_use = function(itemstack, user, pointed_thing)
        return core_1042.eat(itemstack, user, 2, 15)
    end,

    groups = {plant = 1, attached_node = 3, dig_immediate = 1},
})

core.register_node("1042_core:strawberries", {
    description = core_1042.lorelang.translate("Strawberries"),
    drawtype = "plantlike",
    tiles = {"1042_strawberries.png"},
    use_texture_alpha = "clip",

    paramtype = "light",
    sunlight_propagates = true,
    floodable = true,
    walkable = false,

    sounds = {
        dug = {
            name = "turf",
            gain = 0.4,
            pitch = 1.7
        },
        place = {
            name = "turf",
            gain = 0.4,
            pitch = 1.7
        }
    },

    _1042_on_use = function(itemstack, user, pointed_thing)
        return core_1042.eat(itemstack, user, 2, 15)
    end,

    groups = {plant = 1, attached_node = 3, dig_immediate = 1},
})

core.register_node("1042_core:blueberries", {
    description = core_1042.lorelang.translate("Blueberries"),
    drawtype = "plantlike",
    tiles = {"1042_blueberries.png"},
    use_texture_alpha = "clip",

    paramtype = "light",
    sunlight_propagates = true,
    floodable = true,
    walkable = false,

    sounds = {
        dug = {
            name = "turf",
            gain = 0.4,
            pitch = 1.7
        },
        place = {
            name = "turf",
            gain = 0.4,
            pitch = 1.7
        }
    },

    _1042_on_use = function(itemstack, user, pointed_thing)
        return core_1042.eat(itemstack, user, 2, 15)
    end,

    groups = {plant = 1, attached_node = 3, dig_immediate = 1},
})

core.register_node("1042_core:sword_grass", {
    description = core_1042.lorelang.translate("Swordgass"),
    drawtype = "plantlike",
    tiles = {"1042_sword_grass.png"},
    use_texture_alpha = "clip",

    paramtype = "light",
    sunlight_propagates = true,
    floodable = true,
    walkable = false,
    buildable_to = false,

    sounds = {
        dug = {
            name = "turf",
            gain = 0.4,
            pitch = 1.7
        },
        place = {
            name = "turf",
            gain = 0.4,
            pitch = 1.7
        }
    },

    _1042_on_use = function(itemstack, user, pointed_thing)
        return core_1042.eat(itemstack, user, 1, 3)
    end,


    paramtype2 = "meshoptions",
    place_param2 = 16 + 32 + 4,

    groups = {plant = 1, attached_node = 3, dig_immediate = 1, burns = 1},
})

core.register_node("1042_core:grass_dry", {
    description = core_1042.lorelang.translate("Dry Grass"),
    drawtype = "plantlike",
    tiles = {"1042_grass_dry.png"},
    use_texture_alpha = "clip",

    paramtype = "light",
    sunlight_propagates = true,
    floodable = true,
    walkable = false,
    buildable_to = false,

    sounds = {
        dug = {
            name = "turf",
            gain = 0.4,
            pitch = 1.7
        },
        place = {
            name = "turf",
            gain = 0.4,
            pitch = 1.7
        }
    },

    _1042_on_use = function(itemstack, user, pointed_thing)
        return core_1042.eat(itemstack, user, 1, 3)
    end,


    paramtype2 = "meshoptions",
    place_param2 = 16 + 32 + 4,

    groups = {plant = 1, attached_node = 3, dig_immediate = 1, burns = 2},
})

-- TODO: Seaweed, Lilypads, Milfoil

core.register_node("1042_core:marsh_grass", {
    description = core_1042.lorelang.translate("Marsh Grass"),
    drawtype = "plantlike",
    tiles = {"1042_marsh_grass.png"},
    use_texture_alpha = "clip",

    paramtype = "light",
    sunlight_propagates = true,
    floodable = true,
    walkable = false,
    buildable_to = false,

    sounds = {
        dug = {
            name = "turf",
            gain = 0.4,
            pitch = 1.7
        },
        place = {
            name = "turf",
            gain = 0.4,
            pitch = 1.7
        }
    },

    _1042_on_use = function(itemstack, user, pointed_thing)
        return core_1042.eat(itemstack, user, 1, 3)
    end,


    paramtype2 = "meshoptions",
    place_param2 = 16 + 32 + 4,

    groups = {plant = 1, attached_node = 3, dig_immediate = 1, burns = 2},
})

core.register_node("1042_core:tufted_grass", {
    description = core_1042.lorelang.translate("Tufted Grass"),
    drawtype = "plantlike",
    tiles = {"1042_tufted_grass.png"},
    use_texture_alpha = "clip",

    paramtype = "light",
    sunlight_propagates = true,
    floodable = true,
    walkable = false,
    buildable_to = false,

    sounds = {
        dug = {
            name = "turf",
            gain = 0.4,
            pitch = 1.7
        },
        place = {
            name = "turf",
            gain = 0.4,
            pitch = 1.7
        }
    },

    _1042_on_use = function(itemstack, user, pointed_thing)
        return core_1042.eat(itemstack, user, 1, 3)
    end,


    paramtype2 = "meshoptions",
    place_param2 = 16 + 32 + 4,

    groups = {plant = 1, attached_node = 3, dig_immediate = 1, burns = 2},
})

core.register_node("1042_core:branch_cactus", {
    description = core_1042.lorelang.translate("Saguaro Cactus"),
    drawtype = "mesh",
    mesh = "branch_cactus.obj",
    tiles = {"1042_cactus_branched.png"},

    paramtype = "light",
    paramtype2 = "facedir",
    sunlight_propagates = true,
    walkable = true,

    _1042_on_use = function(itemstack, user, pointed_thing)
        return core_1042.eat(itemstack, user, 1, 3)
    end,
    groups = {plant = 1, attached_node = 3, dig_immediate = 1},
})

core.register_node("1042_core:barrel_cactus", {
    description = core_1042.lorelang.translate("Barrel Cactus"),
    drawtype = "nodebox",
    tiles = {"1042_cactus_barrel.png"},

    node_box = {
        type = "fixed",
        fixed = {-2/8, -4/8, -2/8, 2/8, 2/8, 2/8}
    },

    paramtype = "light",
    paramtype2 = "facedir",
    sunlight_propagates = true,

    _1042_on_use = function(itemstack, user, pointed_thing)
        return core_1042.eat(itemstack, user, 1, 5)
    end,
    groups = {plant = 1, attached_node = 3, dig_immediate = 1},
})

core.register_node("1042_core:short_palm", {
    description = core_1042.lorelang.translate("Sago Palm"),
    drawtype = "mesh",
    mesh = "short_palm.obj",
    tiles = {"1042_palm_short.png"},
    use_texture_alpha = "clip",

    paramtype = "light",
    paramtype2 = "facedir",
    sunlight_propagates = true,
    walkable = true,

    groups = {plant = 1, attached_node = 3, wood = 1},
})

core.register_node("1042_core:hanging_moss", {
    description = core_1042.lorelang.translate("Hanging Moss"),
    drawtype = "plantlike",
    tiles = {"1042_hanging_moss.png"},
    use_texture_alpha = "clip",

    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    climbable = true,

    groups = {plant = 1, attached_node = 4, dig_immediate = 1}, -- TODO: not hanging on itself anymore for some reason
})

core.register_node("1042_core:coconut", {
    description = core_1042.lorelang.translate("Coconut"),
    drawtype = "nodebox",
    tiles = {"1042_coconut.png"},

    node_box = {
        type = "fixed",
        fixed = {-3/8, -3/8, -3/8, 3/8, 3/8, 3/8}
    },

    paramtype = "light",
    paramtype2 = "facedir",
    sunlight_propagates = true,

    _1042_on_use = function(itemstack, user, pointed_thing)
        return core_1042.eat(itemstack, user, 2, 15)
    end,
    groups = {plant = 1, attached_node = 1, dig_immediate = 1},
})