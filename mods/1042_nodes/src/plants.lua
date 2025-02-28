

-- Plants


core.register_node("1042_nodes:grass_tall", {
    description = "Tall Grass",
    drawtype = "mesh",
    mesh = "grass_tall.obj",
    tiles = {"1042_plain_node.png^[colorize:#278b13:168"},
    use_texture_alpha = "opaque",

    paramtype = "light",
    sunlight_propagates = true,
    floodable = true,
    walkable = false,
    buildable_to = true,

    groups = {leafy = 1, plant = 1, attached_node = 3, breakable_by_hand = 1, burns = 1},
})

core.register_node("1042_nodes:grass_short", {
    description = "Short Grass",
    drawtype = "mesh",
    mesh = "grass_short.obj",
    tiles = {"1042_plain_node.png^[colorize:#278b13:168"},
    use_texture_alpha = "opaque",

    paramtype = "light",
    sunlight_propagates = true,
    floodable = true,
    walkable = false,
    buildable_to = true,

    groups = {leafy = 1, plant = 1, attached_node = 3, breakable_by_hand = 1, burns = 1},
})

core.register_node("1042_nodes:grass_snowy", {
    description = "Snowy Grass",
    drawtype = "mesh",
    mesh = "grass_short.obj",
    tiles = {"1042_plain_node.png^[colorize:#278b13:144^[colorize:#ffffff:168"},
    use_texture_alpha = "opaque",

    paramtype = "light",
    sunlight_propagates = true,
    floodable = true,
    walkable = false,
    buildable_to = true,

    groups = {leafy = 1, plant = 1, attached_node = 3, breakable_by_hand = 1, burns = 1},
})

core.register_node("1042_nodes:mushroom", {
    description = "Mushroom",
    drawtype = "mesh",
    mesh = "mushroom.obj",
    tiles = {"1042_plain_node.png^[colorize:#7B3500:64"},
    use_texture_alpha = "opaque",

    paramtype = "light",
    sunlight_propagates = true,
    floodable = true,
    walkable = false,
    buildable_to = false,

    _1042_on_use = function(itemstack, user, pointed_thing)
        return core_1042.eat(itemstack, user, 2, 10)
    end,

    groups = {plant = 1, attached_node = 3, breakable_by_hand = 1, burns = 1},
})

core.register_node("1042_nodes:apple", {
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



-- WIP
core.register_node("1042_nodes:sapling_plain", {
    description = "Plain Sapling",
    drawtype = "mesh",
    mesh = "sapling.obj",
    wield_scale = {x = 0.1, y = 0.1, z = 0.1},
    tiles = {
		"1042_plain_node.png^[colorize:#672307:200",
		"1042_plain_node.png^[colorize:#278b13:168"
	},
    use_texture_alpha = "blend",

    paramtype = "light",
    sunlight_propagates = true,
    walkable = true,
    buildable_to = false,

    groups = {plant = 1, breakable_by_hand = 1, not_in_creative_inventory = 1},
})

-- Flowers

core.register_node("1042_nodes:flower_1", {
    description = "Flower",
    drawtype = "mesh",
    mesh = "flower_1.obj",
    tiles = {
        "1042_plain_node.png^[colorize:#11AA22:64", -- stem
        "1042_plain_node.png^[colorize:#AA2211:64", -- petal
        "1042_plain_node.png^[colorize:#22AA11:64"  -- leaf
    },
    use_texture_alpha = "opaque",

    paramtype = "light",
    sunlight_propagates = true,
    floodable = true,
    walkable = false,
    buildable_to = false,

    groups = {plant = 1, attached_node = 3, breakable_by_hand = 1, burns = 1, flower = 1},
})

core.register_node("1042_nodes:flower_2", {
    description = "Flower",
    drawtype = "mesh",
    mesh = "flower_2.obj",
    tiles = {
        "1042_plain_node.png^[colorize:#119922:64", -- stem
        "1042_plain_node.png^[colorize:#AA1177:64", -- petal
    },
    use_texture_alpha = "opaque",

    paramtype = "light",
    sunlight_propagates = true,
    floodable = true,
    walkable = false,
    buildable_to = false,

    groups = {plant = 1, attached_node = 3, breakable_by_hand = 1, burns = 1, flower = 2},
})

core.register_node("1042_nodes:flower_3", {
    description = "Flower",
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

core.register_node("1042_nodes:flower_4", {
    description = "Flower",
    drawtype = "mesh",
    mesh = "flower_4.obj",
    tiles = {
        "1042_plain_node.png^[colorize:#11AA22:64", -- stem
        "1042_plain_node.png^[colorize:#FFAA11:64", -- petal
        "1042_plain_node.png^[colorize:#22AA11:64"  -- leaf
    },
    use_texture_alpha = "opaque",

    paramtype = "light",
    sunlight_propagates = true,
    floodable = true,
    walkable = false,
    buildable_to = false,

    groups = {plant = 1, attached_node = 3, breakable_by_hand = 1, burns = 1, flower = 4},
})