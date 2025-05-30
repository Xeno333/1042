

-- Trees


core_1042.trees.register_tree("1042_core", {
    name = "Dark",
    
    tree = {
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
    },
    leaves = {
        tiles = {"1042_plain_node.png^[colorize:#1f470a:168"},
        use_texture_alpha = "blend",
        drawtype = "allfaces",
        
        paramtype = "light",
        sunlight_propagates = true,

        groups = {leafy = 1, plant = 1, breakable_by_hand = 1, burns = 1},
    }
})

core_1042.trees.register_tree("1042_core", {
    name = "",
    
    tree = {
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
    },
    leaves = {
        tiles = {"1042_plain_node.png^[colorize:#1c770a:168"},
        use_texture_alpha = "blend",
        drawtype = "allfaces",
        
        paramtype = "light",
        sunlight_propagates = true,
    
        groups = {leafy = 1, plant = 1, breakable_by_hand = 1, burns = 1},
    }
})


core_1042.trees.register_tree("1042_core", {
    name = "Light",
    
    tree = {
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
    },
    leaves = {
        tiles = {"1042_plain_node.png^[colorize:#99cc99:168"},
        use_texture_alpha = "blend",
        drawtype = "allfaces",
        
        paramtype = "light",
        sunlight_propagates = true,
    
        groups = {leafy = 1, plant = 1, breakable_by_hand = 1, burns = 1},
    }
})