

-- Plants


-- Grasses are an extension of turf

local c = core.colorize

core.register_node("1042_core:grass_tall", {
    description = "Tall Grass",
    drawtype = "mesh",
    mesh = "grass_tall.obj",
    tiles = {"turf.png"},
    use_texture_alpha = "opaque",

    paramtype = "light",
    sunlight_propagates = true,
    floodable = true,
    walkable = false,
    buildable_to = true,

    color = "#309913ff",
    paramtype2 = "color",
    palette = "turf_palette.png",
    node_placement_prediction = "",

    sounds = {
        dig = {
            name = "turf",
            gain = 0.4,
            pitch = 1.6
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
            node.param2 = weather.get_biome_palette_index(weather.get_temp_single(pos))
            core.swap_node(pos, node)
        end
    end,

    -- Add self as a drop to avoid meta
    drop = "",
    preserve_metadata = function(_, _, _, drops)
        drops[#drops+1] = ItemStack("1042_core:grass_tall")
    end,

    groups = {leafy = 1, plant = 1, attached_node = 3, breakable_by_hand = 1, burns = 1},
})

core.register_node("1042_core:grass_short", {
    description = "Short Grass",
    drawtype = "mesh",
    mesh = "grass_short.obj",
    tiles = {"turf.png"},
    use_texture_alpha = "opaque",

    paramtype = "light",
    sunlight_propagates = true,
    floodable = true,
    walkable = false,
    buildable_to = true,

    color = "#309913ff",
    paramtype2 = "color",
    palette = "turf_palette.png",
    node_placement_prediction = "",

    sounds = {
        dig = {
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
            node.param2 = weather.get_biome_palette_index(weather.get_temp_single(pos))
            core.swap_node(pos, node)
        end
    end,

    -- Add self as a drop to avoid meta
    drop = "",
    preserve_metadata = function(_, _, _, drops)
        drops[#drops+1] = ItemStack("1042_core:grass_short")
    end,

    groups = {leafy = 1, plant = 1, attached_node = 3, breakable_by_hand = 1, burns = 1},
})









core.register_node("1042_core:mushroom", {
    description = "Mushroom",
    drawtype = "mesh",
    mesh = "mushroom.obj",
    tiles = {"1042_plain_node.png^[colorize:#7B3500:128"},
    use_texture_alpha = "opaque",

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

    groups = {plant = 1, attached_node = 1, breakable_by_hand = 1, burns = 1, growth = 1, growth_bio_mass = 4, bio_mass = 1}, -- #fixme Add growth, and biomater types to docs
})

core.register_node("1042_core:apple", {
    description = "Apple",
    drawtype = "mesh",
    mesh = "fruit.obj",
    tiles = {"1042_plain_node.png^[colorize:#ff0000:128"},
    use_texture_alpha = "opaque",

    paramtype = "light",
    sunlight_propagates = true,
    walkable = true,
    buildable_to = false,
    
    _1042_on_use = function(itemstack, user, pointed_thing)
        return core_1042.eat(itemstack, user, 2, nil)
    end,

    groups = {plant = 1, food = 1, breakable_by_hand = 1},
})







-- Flowers

core.register_node("1042_core:light_bloom", {
    description = "Light bloom",
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

    groups = {plant = 1, attached_node = 3, breakable_by_hand = 1, burns = 1, flower = 1},
})

core.register_node("1042_core:digitalis", {
    description = "Digitalis",
    drawtype = "mesh",
    mesh = "digitalis.obj",
    tiles = {
        "1042_plain_node.png^[colorize:#063803:164", -- stem
        "1042_plain_node.png^[colorize:#991177:64", -- petal
    },
    use_texture_alpha = "opaque",

    paramtype = "light",
    sunlight_propagates = true,
    floodable = true,
    walkable = false,
    buildable_to = false,

    sounds = {
        dig = {
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

    groups = {plant = 1, attached_node = 3, breakable_by_hand = 1, burns = 1, flower = 2},
})

core.register_node("1042_core:tulip", {
    description = "Tulip",
    drawtype = "mesh",
    mesh = "flower_3.obj",
    tiles = {
        "1042_plain_node.png^[colorize:#11AA22:64", -- stem
        "1042_plain_node.png^[colorize:#7711AA:64", -- petal
        "1042_plain_node.png^[colorize:#22AA11:64"  -- leaf
    },
    use_texture_alpha = "opaque",

    paramtype = "light",
    sunlight_propagates = true,
    floodable = true,
    walkable = false,
    buildable_to = false,

    groups = {plant = 1, attached_node = 3, breakable_by_hand = 1, burns = 1, flower = 3},
})

core.register_node("1042_core:sunflower", {
    description = "Sunflower",
    drawtype = "mesh",
    mesh = "flower_4.obj",
    tiles = {
        "1042_plain_node.png^[colorize:#11AA22:64", -- stem
        "1042_plain_node.png^[colorize:#FFAA11:64", -- petal
        "1042_plain_node.png^[colorize:#22AA11:64"  -- leaf
    },
    use_texture_alpha = "opaque",

    paramtype = "light",
    paramtype2 = "4dir",
    sunlight_propagates = true,
    floodable = true,
    walkable = false,
    buildable_to = false,

    groups = {plant = 1, attached_node = 3, breakable_by_hand = 1, burns = 1, flower = 4},
})
