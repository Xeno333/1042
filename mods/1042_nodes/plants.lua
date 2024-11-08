

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

    on_use = function(itemstack, user, pointed_thing)
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
    
    on_use = function(itemstack, user, pointed_thing)
        return core_1042.eat(itemstack, user, 2, nil)
    end,

    groups = {plant = 1, food = 1, breakable_by_hand = 1},
})
