

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
    tiles = {"1042_plain_node.png^[colorize:#bbbbff:72"},
    use_texture_alpha = "blend",
	paramtype = "light",

    groups = {falling_node = 1, float = 1, melts = 1, slippery = 3, cools = 1},
})

core.register_node("1042_nodes:turf", {
    description = "Turf",
    tiles = {"1042_plain_node.png^[colorize:#278b13:168"},
    use_texture_alpha = "opaque",

    groups = {dirt = 1, breakable_by_hand = 1},
})

core.register_node("1042_nodes:turf_dry", {
    description = "Dry Turf",
    tiles = {"1042_plain_node.png^[colorize:#578b33:168"},
    use_texture_alpha = "opaque",

    groups = {dirt = 1, breakable_by_hand = 1},
})

core.register_node("1042_nodes:snow", {
    description = "Snow",
    tiles = {"1042_plain_node.png^[colorize:#ffffff:168"},
    use_texture_alpha = "opaque",

    groups = {cools = 1, melts = 1, breakable_by_hand = 1},
})

core.register_node("1042_nodes:stone", {
    description = "Stone",
    tiles = {"1042_plain_node.png^[colorize:#777777:128"},
    use_texture_alpha = "opaque",

    groups = {stone = 1},
})

core.register_node("1042_nodes:basalt", {
    description = "Basalt",
    tiles = {"1042_plain_node.png^[colorize:#111111:128"},
    use_texture_alpha = "opaque",

    groups = {stone = 2},
})

core.register_node("1042_nodes:iorn_ore", {
    description = "Iorn Ore",
    tiles = {"1042_plain_node.png^[colorize:#551111:128"},
    use_texture_alpha = "opaque",

    drop = {
        max_items = 5,
        items = {
            {
                rarity = 1,
                items = {"1042_nodes:iorn_nugget"}
            },
            {
                rarity = 2,
                items = {"1042_nodes:iorn_nugget"}
            },
            {
                rarity = 4,
                items = {"1042_nodes:iorn_nugget"}
            },
            {
                rarity = 8,
                items = {"1042_nodes:rock"}
            }
        }
    },

    groups = {stone = 3},
})



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

    groups = {wood = 1, plant = 1, burns = 1},
})

core.register_node("1042_nodes:tree_dark", {
    description = "Dark Tree",
    tiles = {"1042_plain_node.png^[colorize:#371307:200"},
    use_texture_alpha = "opaque",

    groups = {wood = 1, plant = 1, burns = 1},
})

core.register_node("1042_nodes:tree_light", {
    description = "Light Tree",
    tiles = {"1042_plain_node.png^[colorize:#676357:200"},
    use_texture_alpha = "opaque",

    groups = {wood = 1, plant = 1, burns = 1},
})
