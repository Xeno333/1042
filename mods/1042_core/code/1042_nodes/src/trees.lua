

-- Trees


core_1042.trees.register_tree("1042_core", {
    name = "Dark",

    tree = {
        tiles = {"1042_tree_dark.png"},
        --tiles = {"1042_plain_node.png^[colorize:#371307:200"},
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
        tiles = {"1042_tree_dark_leaves.png"},
        special_tiles = {"1042_tree_dark_leaves_simple.png"},
        use_texture_alpha = "blend",
        drawtype = "allfaces_optional",

        paramtype = "light",
        sunlight_propagates = true,

        groups = {leafy = 1, plant = 1, breakable_by_hand = 1, burns = 1},
    },
    planks = {
        tiles = {"1042_tree_dark_planks.png"},
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
})

core_1042.trees.register_tree("1042_core", {
    name = "",
    
    tree = {
        tiles = {"1042_tree.png"},
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
        tiles = {"1042_tree_leaves.png"},
        special_tiles = {"1042_tree_leaves_simple.png"},
        --tiles = {"1042_plain_node.png^[colorize:#1c770a:168"},
        use_texture_alpha = "blend",
        drawtype = "allfaces_optional",

        paramtype = "light",
        sunlight_propagates = true,

        groups = {leafy = 1, plant = 1, breakable_by_hand = 1, burns = 1},
    },
    planks = {
        tiles = {"1042_tree_planks.png"},
        --tiles = {"1042_plain_node.png^[colorize:#672307:128"},
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
})


core_1042.trees.register_tree("1042_core", {
    name = "Light",

    tree = {
        tiles = {"1042_tree_light.png"},
        --tiles = {"1042_plain_node.png^[colorize:#676357:200"},
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
        tiles = {"1042_tree_light_leaves.png"},
        special_tiles = {"1042_tree_light_leaves_simple.png"},
        --tiles = {"1042_plain_node.png^[colorize:#99cc99:168"},
        use_texture_alpha = "blend",
        drawtype = "allfaces_optional",

        paramtype = "light",
        sunlight_propagates = true,

        groups = {leafy = 1, plant = 1, breakable_by_hand = 1, burns = 1},
    },
    planks = {
        tiles = {"1042_tree_light_planks.png"},
        --tiles = {"1042_plain_node.png^[colorize:#676357:128"},
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
})

core_1042.trees.register_tree("1042_core", {
    name = "Willow",

    tree = {
        tiles = {"1042_tree_willow.png"},
        --tiles = {"1042_plain_node.png^[colorize:#371307:200"},
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
        tiles = {"1042_tree_willow_leaves.png"},
        special_tiles = {"1042_tree_willow_leaves_simple.png"},
        use_texture_alpha = "blend",
        drawtype = "allfaces_optional",

        paramtype = "light",
        sunlight_propagates = true,

        groups = {leafy = 1, plant = 1, breakable_by_hand = 1, burns = 1},
    },
    planks = {
        tiles = {"1042_tree_willow_planks.png"},
        use_texture_alpha = "opaque",
    
        sounds = {
            dig = {
                name = "tree_dig",
                gain = 2,
                pitch = 0.75
            }
        },

        groups = {wood = 1, plant = 1, burns = 4},
    },
})

core_1042.trees.register_tree("1042_core", {
    name = "Mangrove",

    tree = {
        tiles = {"1042_tree_mangrove.png"},
        --tiles = {"1042_plain_node.png^[colorize:#371307:200"},
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
        tiles = {"1042_tree_mangrove_leaves.png"},
        special_tiles = {"1042_tree_mangrove_leaves_simple.png"},
        use_texture_alpha = "blend",
        drawtype = "allfaces_optional",

        paramtype = "light",
        sunlight_propagates = true,

        groups = {leafy = 1, plant = 1, breakable_by_hand = 1, burns = 1},
    },
    planks = {
        tiles = {"1042_tree_mangrove_planks.png"},
        use_texture_alpha = "opaque",
    
        sounds = {
            dig = {
                name = "tree_dig",
                gain = 2,
                pitch = 0.75
            }
        },

        groups = {wood = 1, plant = 1, burns = 4},
    },
})

core.register_node("1042_core:roots_mangrove", {
    description = core_1042.lorelang.translate("Mangrove Roots"),
    tiles = {"1042_tree_mangrove_roots.png"},
    groups = {wood = 1, breakable_by_hand = 1, burns = 2},
})

core_1042.trees.register_tree("1042_core", {
    name = "Acacia",

    tree = {
        tiles = {"1042_tree_acacia.png"},
        --tiles = {"1042_plain_node.png^[colorize:#371307:200"},
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
        tiles = {"1042_tree_acacia_leaves.png"},
        special_tiles = {"1042_tree_acacia_leaves_simple.png"},
        use_texture_alpha = "blend",
        drawtype = "allfaces_optional",

        paramtype = "light",
        sunlight_propagates = true,

        groups = {leafy = 1, plant = 1, breakable_by_hand = 1, burns = 1},
    },
    planks = {
        tiles = {"1042_tree_acacia_planks.png"},
        use_texture_alpha = "opaque",
    
        sounds = {
            dig = {
                name = "tree_dig",
                gain = 2,
                pitch = 0.75
            }
        },

        groups = {wood = 1, plant = 1, burns = 4},
    },
})

core_1042.trees.register_tree("1042_core", {
    name = "Willow",

    tree = {
        tiles = {"1042_tree_willow.png"},
        --tiles = {"1042_plain_node.png^[colorize:#371307:200"},
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
        tiles = {"1042_tree_willow_leaves.png"},
        special_tiles = {"1042_tree_willow_leaves_simple.png"},
        use_texture_alpha = "blend",
        drawtype = "allfaces_optional",

        paramtype = "light",
        sunlight_propagates = true,

        groups = {leafy = 1, plant = 1, breakable_by_hand = 1, burns = 1},
    },
    planks = {
        tiles = {"1042_tree_willow_planks.png"},
        use_texture_alpha = "opaque",
    
        sounds = {
            dig = {
                name = "tree_dig",
                gain = 2,
                pitch = 0.75
            }
        },

        groups = {wood = 1, plant = 1, burns = 4},
    },
})

core_1042.trees.register_tree("1042_core", {
    name = "Palm",

    tree = {
        tiles = {"1042_tree_palm.png"},
        --tiles = {"1042_plain_node.png^[colorize:#371307:200"},
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
        tiles = {"1042_tree_palm_leaves.png"},
        special_tiles = {"1042_tree_palm_leaves_simple.png"},
        use_texture_alpha = "blend",
        drawtype = "allfaces_optional",

        paramtype = "light",
        sunlight_propagates = true,

        groups = {leafy = 1, plant = 1, breakable_by_hand = 1, burns = 1},
    },
    planks = {
        tiles = {"1042_tree_palm_planks.png"},
        use_texture_alpha = "opaque",
    
        sounds = {
            dig = {
                name = "tree_dig",
                gain = 2,
                pitch = 0.75
            }
        },

        groups = {wood = 1, plant = 1, burns = 4},
    },
})

core_1042.trees.register_tree("1042_core", {
    name = "Spruce",

    tree = {
        tiles = {"1042_tree_spruce.png"},
        --tiles = {"1042_plain_node.png^[colorize:#371307:200"},
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
        tiles = {"1042_tree_spruce_leaves.png"},
        special_tiles = {"1042_tree_spruce_leaves_simple.png"},
        use_texture_alpha = "blend",
        drawtype = "allfaces_optional",

        paramtype = "light",
        sunlight_propagates = true,

        groups = {leafy = 1, plant = 1, breakable_by_hand = 1, burns = 1},
    },
    planks = {
        tiles = {"1042_tree_spruce_planks.png"},
        use_texture_alpha = "opaque",
    
        sounds = {
            dig = {
                name = "tree_dig",
                gain = 2,
                pitch = 0.75
            }
        },

        groups = {wood = 1, plant = 1, burns = 4},
    },
})

core_1042.trees.register_tree("1042_core", {
    name = "Pine",

    tree = {
        tiles = {"1042_tree_pine.png"},
        --tiles = {"1042_plain_node.png^[colorize:#371307:200"},
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
        tiles = {"1042_tree_pine_leaves.png"},
        special_tiles = {"1042_tree_pine_leaves_simple.png"},
        use_texture_alpha = "blend",
        drawtype = "allfaces_optional",

        paramtype = "light",
        sunlight_propagates = true,

        groups = {leafy = 1, plant = 1, breakable_by_hand = 1, burns = 1},
    },
    planks = {
        tiles = {"1042_tree_pine_planks.png"},
        use_texture_alpha = "opaque",
    
        sounds = {
            dig = {
                name = "tree_dig",
                gain = 2,
                pitch = 0.75
            }
        },

        groups = {wood = 1, plant = 1, burns = 4},
    },
})

core_1042.trees.register_tree("1042_core", {
    name = "Aspen",

    tree = {
        tiles = {"1042_tree_aspen.png"},
        --tiles = {"1042_plain_node.png^[colorize:#371307:200"},
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
        tiles = {"1042_tree_aspen_leaves.png"},
        special_tiles = {"1042_tree_aspen_leaves_simple.png"},
        use_texture_alpha = "blend",
        drawtype = "allfaces_optional",

        paramtype = "light",
        sunlight_propagates = true,

        groups = {leafy = 1, plant = 1, breakable_by_hand = 1, burns = 1},
    },
    planks = {
        tiles = {"1042_tree_aspen_planks.png"},
        use_texture_alpha = "opaque",
    
        sounds = {
            dig = {
                name = "tree_dig",
                gain = 2,
                pitch = 0.75
            }
        },

        groups = {wood = 1, plant = 1, burns = 4},
    },
})

core_1042.trees.register_tree("1042_core", {
    name = "Birch",

    tree = {
        tiles = {"1042_tree_birch.png"},
        --tiles = {"1042_plain_node.png^[colorize:#371307:200"},
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
        tiles = {"1042_tree_birch_leaves.png"},
        special_tiles = {"1042_tree_birch_leaves_simple.png"},
        use_texture_alpha = "blend",
        drawtype = "allfaces_optional",

        paramtype = "light",
        sunlight_propagates = true,

        groups = {leafy = 1, plant = 1, breakable_by_hand = 1, burns = 1},
    },
    planks = {
        tiles = {"1042_tree_birch_planks.png"},
        use_texture_alpha = "opaque",
    
        sounds = {
            dig = {
                name = "tree_dig",
                gain = 2,
                pitch = 0.75
            }
        },

        groups = {wood = 1, plant = 1, burns = 4},
    },
})

core_1042.trees.register_tree("1042_core", {
    name = "Oak",

    tree = {
        tiles = {"1042_tree_oak.png"},
        --tiles = {"1042_plain_node.png^[colorize:#371307:200"},
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
        tiles = {"1042_tree_oak_leaves.png"},
        special_tiles = {"1042_tree_oak_leaves_simple.png"},
        use_texture_alpha = "blend",
        drawtype = "allfaces_optional",

        paramtype = "light",
        sunlight_propagates = true,

        groups = {leafy = 1, plant = 1, breakable_by_hand = 1, burns = 1},
    },
    planks = {
        tiles = {"1042_tree_oak_planks.png"},
        use_texture_alpha = "opaque",
    
        sounds = {
            dig = {
                name = "tree_dig",
                gain = 2,
                pitch = 0.75
            }
        },

        groups = {wood = 1, plant = 1, burns = 4},
    },
})

core_1042.trees.register_tree("1042_core", {
    name = "Elm",

    tree = {
        tiles = {"1042_tree_elm.png"},
        --tiles = {"1042_plain_node.png^[colorize:#371307:200"},
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
        tiles = {"1042_tree_elm_leaves.png"},
        special_tiles = {"1042_tree_elm_leaves_simple.png"},
        use_texture_alpha = "blend",
        drawtype = "allfaces_optional",

        paramtype = "light",
        sunlight_propagates = true,

        groups = {leafy = 1, plant = 1, breakable_by_hand = 1, burns = 1},
    },
    planks = {
        tiles = {"1042_tree_elm_planks.png"},
        use_texture_alpha = "opaque",
    
        sounds = {
            dig = {
                name = "tree_dig",
                gain = 2,
                pitch = 0.75
            }
        },

        groups = {wood = 1, plant = 1, burns = 4},
    },
})

core_1042.trees.register_tree("1042_core", {
    name = "Maple",

    tree = {
        tiles = {"1042_tree_maple.png"},
        --tiles = {"1042_plain_node.png^[colorize:#371307:200"},
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
        tiles = {"1042_tree_maple_leaves.png"},
        special_tiles = {"1042_tree_maple_leaves_simple.png"},
        use_texture_alpha = "blend",
        drawtype = "allfaces_optional",

        paramtype = "light",
        sunlight_propagates = true,

        groups = {leafy = 1, plant = 1, breakable_by_hand = 1, burns = 1},
    },
    planks = {
        tiles = {"1042_tree_maple_planks.png"},
        use_texture_alpha = "opaque",
    
        sounds = {
            dig = {
                name = "tree_dig",
                gain = 2,
                pitch = 0.75
            }
        },

        groups = {wood = 1, plant = 1, burns = 4},
    },
})

core_1042.trees.register_tree("1042_core", {
    name = "Beech",

    tree = {
        tiles = {"1042_tree_beech.png"},
        --tiles = {"1042_plain_node.png^[colorize:#371307:200"},
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
        tiles = {"1042_tree_beech_leaves.png"},
        special_tiles = {"1042_tree_beech_leaves_simple.png"},
        use_texture_alpha = "blend",
        drawtype = "allfaces_optional",

        paramtype = "light",
        sunlight_propagates = true,

        groups = {leafy = 1, plant = 1, breakable_by_hand = 1, burns = 1},
    },
    planks = {
        tiles = {"1042_tree_beech_planks.png"},
        use_texture_alpha = "opaque",
    
        sounds = {
            dig = {
                name = "tree_dig",
                gain = 2,
                pitch = 0.75
            }
        },

        groups = {wood = 1, plant = 1, burns = 4},
    },
})