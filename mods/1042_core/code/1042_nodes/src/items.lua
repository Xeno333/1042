
local function hit_flint_with_iron(itemstack, player, pointed_thing)
    local node = nil
    if pointed_thing and pointed_thing.under then
        node = core.get_node(pointed_thing.under)
    end
    if node and node.name == "1042_core:flint" then
        core.sound_play("hit_flint_with_iron", {gain = 1, pos = pointed_thing.under, max_hear_distance = 16}, true)
        core.add_particlespawner({
            pos = pointed_thing.under,
            amount = 10,
            time = 0.1,

            collisiondetection = true,
            object_collision = true,
            collision_removal = true,

            vel = {
                min = vector.new(-2, 1, -2),
                max = vector.new(2, 4, 2),
                bias = 0
            },

            acc = vector.new(0, -9.8, 0),

            size = {
                min = 0.05,
                max = 0.3
            },

            exptime = {
                min = 0.2,
                max = 1
            },

            glow = 14,

            name = player:get_player_name(),

            texture = "1042_plain_node.png^[colorize:#ffcc66:144"
        })

        if math.random(1, 10) == 1 then
            local nodes = core.find_nodes_in_area_under_air(vector.add(pointed_thing.under, vector.new(-1, -1, -1)), vector.add(pointed_thing.under, vector.new(1, 1, 1)), "group:burns")
            if #nodes > 0 then
                achievements_1042.achieve(player, "oooo_fire")
                core.set_node(vector.add(nodes[math.random(1, #nodes)], vector.new(0, 1, 0)), {name="1042_core:fire"})
            end
        end
    end
end

achievements_1042.register_achievement("oooo_fire", {
    achievement = core.colorize("#ff7755", "Oooo, Fire!"),
    colour = "#ffccaa"
})


core_1042.registry.register_material("1042_core:fire", {
    description = core_1042.lorelang.translate("Fire"),
    drawtype = "firelike",
    tiles = {
        {
            name = "1042_fire_animated.png",
            --name = "[combine:2x8:0,0=1042_plain_node.png\\^[colorize\\:#ff2200\\:128:0,2=1042_plain_node.png\\^[transformR90\\^[colorize\\:#ff3300\\:128:0,4=1042_plain_node.png\\^[transformR180\\^[colorize\\:#ff4400\\:128:0,6=1042_plain_node.png\\^[transformR270\\^[colorize\\:#ff3300\\:128",
            animation = {
                type = "vertical_frames",
                frames_w = 1,
                frames_h = 4,
                --aspect_w = 2,
                --aspect_h = 2,
                length = 0.5,
            }
        },
    },
    use_texture_alpha = "blend",

    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    floodable = true,
    buildable_to = false,

    drop = "",

    light_source = 8,
    damage_per_second = 5,
    
    groups = {breakable_by_hand = 3, burning = 1},

    item_type = "node",
}, 6, nil, nil)


-- Special nodes

core_1042.registry.register_material("1042_core:beryl", {
    description = core_1042.lorelang.translate("Beryl"),
    drawtype = "mesh",
    mesh = "crystal.obj",
    tiles = {"1042_beryl.png"},
    --tiles = {"1042_plain_node.png^[colorize:#66eecc:128"},
    use_texture_alpha = "blend",

    paramtype = "light",
    paramtype2 = "4dir",
    sunlight_propagates = true,
    walkable = true,
    buildable_to = false,

    selection_box = {
        type = "fixed",
        fixed = {-0.35, -0.5, -0.35, 0.35, 0.3, 0.35}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.35, -0.5, -0.35, 0.35, 0.3, 0.35}
    },

    light_source = 5,
    
    groups = {gem = 1, breakable_by_hand = 3, attached_node = 3},

    item_type = "node",
}, 3, nil, nil)

core_1042.registry.register_material("1042_core:beryl_hanging", {
    description = core_1042.lorelang.translate("Hanging Beryl"),
    drawtype = "mesh",
    mesh = "crystal_roof.obj",
    tiles = {"1042_beryl.png"},
    --tiles = {"1042_plain_node.png^[colorize:#66eeee:128"},
    use_texture_alpha = "blend",

    paramtype = "light",
    paramtype2 = "4dir",
    sunlight_propagates = true,
    walkable = true,
    buildable_to = false,

    light_source = 5,
    
    groups = {breakable_by_hand = 3, attached_node = 4},

    item_type = "node",
}, 4, nil, nil)

core_1042.registry.register_material("1042_core:opal", {
    description = core_1042.lorelang.translate("Opal"),
    drawtype = "mesh",
    mesh = "crystal.obj",
    tiles = {"1042_opal.png"},
    --tiles = {"1042_plain_node.png^[colorize:#66eecc:128"},
    use_texture_alpha = "blend",

    paramtype = "light",
    paramtype2 = "4dir",
    sunlight_propagates = true,
    walkable = true,
    buildable_to = false,

    selection_box = {
        type = "fixed",
        fixed = {-0.35, -0.5, -0.35, 0.35, 0.3, 0.35}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.35, -0.5, -0.35, 0.35, 0.3, 0.35}
    },

    light_source = 5,
    
    groups = {gem = 1, breakable_by_hand = 3, attached_node = 3},

    item_type = "node",
}, 2, nil, nil)

core_1042.registry.register_material("1042_core:sapphire", {
    description = core_1042.lorelang.translate("Sapphire"),
    drawtype = "mesh",
    mesh = "crystal.obj",
    tiles = {"1042_sapphire.png"},
    --tiles = {"1042_plain_node.png^[colorize:#66eecc:128"},
    use_texture_alpha = "blend",

    paramtype = "light",
    paramtype2 = "4dir",
    sunlight_propagates = true,
    walkable = true,
    buildable_to = false,

    selection_box = {
        type = "fixed",
        fixed = {-0.35, -0.5, -0.35, 0.35, 0.3, 0.35}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.35, -0.5, -0.35, 0.35, 0.3, 0.35}
    },

    light_source = 5,
    
    groups = {gem = 1, breakable_by_hand = 3, attached_node = 3},

    item_type = "node",
}, 3, nil, nil)

core_1042.registry.register_material("1042_core:ruby", {
    description = core_1042.lorelang.translate("Ruby"),
    drawtype = "mesh",
    mesh = "crystal.obj",
    tiles = {"1042_ruby.png"},
    --tiles = {"1042_plain_node.png^[colorize:#66eecc:128"},
    use_texture_alpha = "blend",

    paramtype = "light",
    paramtype2 = "4dir",
    sunlight_propagates = true,
    walkable = true,
    buildable_to = false,

    selection_box = {
        type = "fixed",
        fixed = {-0.35, -0.5, -0.35, 0.35, 0.3, 0.35}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.35, -0.5, -0.35, 0.35, 0.3, 0.35}
    },

    light_source = 5,
    
    groups = {gem = 1, breakable_by_hand = 3, attached_node = 3},

    item_type = "node",
}, 3, nil, nil)

core_1042.registry.register_material("1042_core:topaz", {
    description = core_1042.lorelang.translate("Topaz"),
    drawtype = "mesh",
    mesh = "crystal.obj",
    tiles = {"1042_topaz.png"},
    --tiles = {"1042_plain_node.png^[colorize:#66eecc:128"},
    use_texture_alpha = "blend",

    paramtype = "light",
    paramtype2 = "4dir",
    sunlight_propagates = true,
    walkable = true,
    buildable_to = false,

    selection_box = {
        type = "fixed",
        fixed = {-0.35, -0.5, -0.35, 0.35, 0.3, 0.35}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.35, -0.5, -0.35, 0.35, 0.3, 0.35}
    },

    light_source = 5,
    
    groups = {gem = 1, breakable_by_hand = 3, attached_node = 3},

    item_type = "node",
}, 4, nil, nil)

core_1042.registry.register_material("1042_core:tourmaline", {
    description = core_1042.lorelang.translate("Tourmaline"),
    drawtype = "mesh",
    mesh = "crystal.obj",
    tiles = {"1042_tourmaline.png"},
    --tiles = {"1042_plain_node.png^[colorize:#66eecc:128"},
    use_texture_alpha = "blend",

    paramtype = "light",
    paramtype2 = "4dir",
    sunlight_propagates = true,
    walkable = true,
    buildable_to = false,

    selection_box = {
        type = "fixed",
        fixed = {-0.35, -0.5, -0.35, 0.35, 0.3, 0.35}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.35, -0.5, -0.35, 0.35, 0.3, 0.35}
    },

    light_source = 5,
    
    groups = {gem = 1, breakable_by_hand = 3, attached_node = 3},

    item_type = "node",
}, 4, nil, nil)

core_1042.registry.register_material("1042_core:emerald", {
    description = core_1042.lorelang.translate("Emerald"),
    drawtype = "mesh",
    mesh = "crystal.obj",
    tiles = {"1042_emerald.png"},
    --tiles = {"1042_plain_node.png^[colorize:#66eecc:128"},
    use_texture_alpha = "blend",

    paramtype = "light",
    paramtype2 = "4dir",
    sunlight_propagates = true,
    walkable = true,
    buildable_to = false,

    selection_box = {
        type = "fixed",
        fixed = {-0.35, -0.5, -0.35, 0.35, 0.3, 0.35}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.35, -0.5, -0.35, 0.35, 0.3, 0.35}
    },

    light_source = 5,
    
    groups = {gem = 1, breakable_by_hand = 3, attached_node = 3},

    item_type = "node",
}, 5, nil, nil)

core_1042.registry.register_material("1042_core:diamond", {
    description = core_1042.lorelang.translate("Diamond"),
    drawtype = "mesh",
    mesh = "crystal.obj",
    tiles = {"1042_diamond.png"},
    --tiles = {"1042_plain_node.png^[colorize:#66eecc:128"},
    use_texture_alpha = "blend",

    paramtype = "light",
    paramtype2 = "4dir",
    sunlight_propagates = true,
    walkable = true,
    buildable_to = false,

    selection_box = {
        type = "fixed",
        fixed = {-0.35, -0.5, -0.35, 0.35, 0.3, 0.35}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.35, -0.5, -0.35, 0.35, 0.3, 0.35}
    },

    light_source = 5,
    
    groups = {gem = 1, breakable_by_hand = 3, attached_node = 3},

    item_type = "node",
}, 5, nil, nil)

core_1042.registry.register_material("1042_core:rock", {
    description = core_1042.lorelang.translate("Rock"),
    drawtype = "mesh",
    mesh = "rock.obj",
    tiles = {"1042_stone.png"},
    --tiles = {"1042_plain_node.png^[colorize:#777777:128"},
    use_texture_alpha = "opaque",


    selection_box = {
        type = "fixed",
        fixed = {-0.4, -0.5, -0.4, 0.4, -0.2, 0.4}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.4, -0.5, -0.4, 0.4, -0.2, 0.4}
    },

    sounds = {
        dig = {
            name = "stone_dig",
            gain = 0.3,
            pitch = 0.5
        },
        place = {
            name = "stone_walk",
            gain = 1,
            pitch = 0.5
        }
    },

    paramtype = "light",
    paramtype2 = "4dir",
    sunlight_propagates = true,
    walkable = true,
    buildable_to = false,

    groups = {breakable_by_hand = 3, attached_node = 3, rock = 1},

    item_type = "node",
}, 1, nil, nil)

core_1042.registry.register_material("1042_core:flint", {
    description = core_1042.lorelang.translate("Flint"),
    drawtype = "mesh",
    mesh = "flint.obj",
    tiles = {"1042_flint.png"},
    --tiles = {"1042_plain_node.png^[colorize:#07070d:128"},
    use_texture_alpha = "opaque",


    selection_box = {
        type = "fixed",
        fixed = {-0.4, -0.5, -0.4, 0.4, -0.2, 0.4}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.4, -0.5, -0.4, 0.4, -0.2, 0.4}
    },


    sounds = {
        dug = {
            name = "stone_dig",
            gain = 0.3,
            pitch = 0.75
        },
        place = {
            name = "stone_walk",
            gain = 0.5,
            pitch = 1.5
        }
    },

    paramtype = "light",
    paramtype2 = "4dir",
    sunlight_propagates = true,
    walkable = true,
    buildable_to = false,
    
    groups = {dig_immediate = 1, attached_node = 3, rock = 1},

    item_type = "node",
}, 1, nil, nil)

core_1042.registry.register_material("1042_core:torch", {
    description = core_1042.lorelang.translate("Torch"),
    drawtype = "nodebox",
    tiles = {"1042_torch_top.png", "1042_torch_side.png"},
    --tiles = {
    --    "1042_plain_node.png^[colorize:#ff9900:128",
    --    "1042_plain_node.png^[colorize:#371307:172"
    --},
    use_texture_alpha = "opaque",

    selection_box = {
        fixed = {
            {-0.1, -0.5, -0.1, 0.1, -0.1, 0.1},
            {-0.15, -0.1, -0.15, 0.15, 0.1, 0.15}
        }
    },
    collision_box = {
        fixed = {
            {-0.1, -0.5, -0.1, 0.1, -0.1, 0.1},
            {-0.15, -0.1, -0.15, 0.15, 0.1, 0.15}
        }
    },
    node_box = {
        type = "fixed",
        fixed = {
            {-0.1, -0.5, -0.1, 0.1, -0.1, 0.1},
            {-0.15, -0.1, -0.15, 0.15, 0.1, 0.15}
        }
    },

    paramtype2 = "4dir",

    paramtype = "light",
    light_source = 10,
    sunlight_propagates = true,
    walkable = false,
    buildable_to = false,
    
    groups = {dig_immediate = 1, attached_node = 3, burning = 1},

    item_type = "node",
}, nil, {
    result = "1042_core:torch",
    type = "1042_default",
    items = {
        "group:burns 5",
    }
}, nil)


core_1042.registry.register_material("1042_core:sticks", {
    description = core_1042.lorelang.translate("Sticks"),
    drawtype = "mesh",
    mesh = "sticks.obj",
    tiles = {"1042_sticks.png"},
    --tiles = {"1042_plain_node.png^[colorize:#672307:172"},
    use_texture_alpha = "opaque",

    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    buildable_to = false,

    sounds = {
        dug = {
            name = "sticks",
            gain = 0.2,
            pitch = 1,
        }
    },
    
    groups = {dig_immediate = 1, attached_node = 3, burns = 1},

    item_type = "node",
}, 1, nil, {name = "1042_core:sticks", max_count = 32})

-- #fixme
core_1042.registry.register_material("1042_core:anvil", {
    description = core_1042.lorelang.translate("Anvil \n(WIP)"),
    drawtype = "mesh",
    mesh = "anvil.obj",
    tiles = {"1042_anvil.png"},
    --tiles = {"1042_plain_node.png^[colorize:#222222:128"},
    use_texture_alpha = "opaque",

    paramtype = "light",
    paramtype2 = "4dir",
    sunlight_propagates = true,
    walkable = true,
    buildable_to = false,

    stack_max = 1,

    selection_box = {
        type = "fixed",
        fixed = {-0.4, -0.5, -0.4, 0.4, 0.3, 0.4}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.4, -0.5, -0.4, 0.4, 0.3, 0.4}
    },

    light_source = 5,
    
    groups = {breakable_by_hand = 3, attached_node = 3},

    item_type = "node",
}, 3, nil, nil)


achievements_1042.register_achievement("smelter", {
    achievement = core.colorize("#ddcc55", "Smelter!"),
    colour = "#ffddaa"
})

core_1042.registry.register_material("1042_core:crude_iron", {
    description = core_1042.lorelang.translate("Crude Iron"),
    drawtype = "mesh",
    mesh = "flint.obj",
    tiles = {"1042_crude_iron.png"},
    --tiles = {"1042_plain_node.png^[colorize:#886666:200"},

    paramtype = "light",
    paramtype2 = "facedir",
    sunlight_propagates = true,
    walkable = true,
    buildable_to = false,

    selection_box = {
        type = "fixed",
        fixed = {-0.4, -0.5, -0.4, 0.4, -0.2, 0.4}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.4, -0.5, -0.4, 0.4, -0.2, 0.4}
    },

    sounds = {
        dig = {
            name = "stone_dig",
            gain = 2,
            pitch = 2
        },
        footstep = {
            name = "stone_walk",
            gain = 0.3,
            pitch = 2
        },
        place = {
            name = "stone_dig",
            gain = 1,
            pitch = 2
        }
    },

    _1042_on_use = hit_flint_with_iron,

    after_dig_node = function(pos, oldnode, oldmetadata, digger)
        achievements_1042.achieve(digger, "smelter")
    end,
    
    groups = {breakable_by_hand = 1, falling_node = 1},

    item_type = "node",
}, 3, nil, {{name = "1042_core:crude_iron", max_count = 6}})

core_1042.registry.register_material("1042_core:candel", {
    description = core_1042.lorelang.translate("Candle"),
    drawtype = "mesh",
    mesh = "candel.obj",
    tiles = {"1042_candle_wax.png", "1042_candle_wick.png"},
    --tiles = {
    --    "1042_plain_node.png^[colorize:#aaaa88:200",
    --    "1042_plain_node.png^[colorize:#554444:200"
    --},

    paramtype = "light",
    paramtype2 = "facedir",
    sunlight_propagates = true,
    walkable = true,
    buildable_to = false,

    node_box = {
        type = "fixed",
        fixed = {-0.25, -0.5, -0.2, 0.25, -0.2, 0.25}
    },
    selection_box = {
        type = "fixed",
        fixed = {-0.25, -0.5, -0.2, 0.25, -0.2, 0.25}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.25, -0.5, -0.2, 0.25, -0.2, 0.25}
    },

    stack_max = 16,

    groups = {dig_immediate = 1, falling_node = 1},

    on_rightclick = function(pos, _, _, itemstack)
        if core.get_item_group(itemstack:get_name(), "burning") > 0 then
            core.set_node(pos, {name = "1042_core:candel_lit"})
        end
    end,

    item_type = "node"
}, 1, nil, {name = "1042_core:candel", max_count = 16})

core_1042.registry.register_material("1042_core:candel_lit", {
    description = core_1042.lorelang.translate("Lit Candle"),
    drawtype = "mesh",
    mesh = "candel.obj",
    tiles = {"1042_candle_wax.png", "1042_candle_flame.png"},
    --tiles = {
    --    "1042_plain_node.png^[colorize:#aaaa88:200",
    --    "1042_plain_node.png^[colorize:#bb9944:200"
    --},

    paramtype = "light",
    paramtype2 = "facedir",
    sunlight_propagates = true,
    walkable = true,
    buildable_to = false,

    light_source = 8,

    drop = "1042_core:candel",

    node_box = {
        type = "fixed",
        fixed = {-0.25, -0.5, -0.2, 0.25, -0.2, 0.25}
    },
    selection_box = {
        type = "fixed",
        fixed = {-0.25, -0.5, -0.2, 0.25, -0.2, 0.25}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.25, -0.5, -0.2, 0.25, -0.2, 0.25}
    },

    stack_max = 16,

    groups = {dig_immediate = 1, falling_node = 1},

    on_rightclick = function(pos)
        core.set_node(pos, {name = "1042_core:candel"})
    end,

    item_type = "node"
}, 1, nil, {})

local function register_metal(name, on_use, base_metal, rarity)
    core_1042.registry.register_material("1042_core:"..name.."_ingot", {
        description = core_1042.lorelang.translate(name:gsub("^%l", string.upper) .. " Ingot"),
        drawtype = "nodebox",
        tiles = {"1042_"..name.."_ingot.png"},
        --tiles = {"1042_plain_node.png^[colorize:#ddaa00:200"},
    
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,
        walkable = true,
        buildable_to = false,
    
        node_box = {
            type = "fixed",
            fixed = {-0.35, -0.5, -0.2, 0.35, -0.2, 0.2}
        },
        selection_box = {
            type = "fixed",
            fixed = {-0.35, -0.5, -0.2, 0.35, -0.2, 0.2}
        },
        collision_box = {
            type = "fixed",
            fixed = {-0.35, -0.5, -0.2, 0.35, -0.2, 0.2}
        },
    
        sounds = {
            dug = {
                name = "stone_dig",
                gain = 2,
                pitch = 2
            },
            footstep = {
                name = "stone_walk",
                gain = 0.3,
                pitch = 2
            },
            place = {
                name = "stone_dig",
                gain = 1,
                pitch = 2
            }
        },

        _1042_on_use = on_use, -- hit_flint_with_iron
    
        after_dig_node = function(pos, oldnode, oldmetadata, digger)
            achievements_1042.achieve(digger, "smelter")
        end,
        
        groups = {dig_immediate = 1, falling_node = 1},
    
        item_type = "node"
    }, rarity, nil, {name = "1042_core:"..name.."_ingot", max_count = 6})

    if base_metal then
        core_1042.registry.register_material("1042_core:"..name.."_nugget", {
            description = core_1042.lorelang.translate(name:gsub("^%l", string.upper) .. " Nugget"),
            drawtype = "mesh",
            mesh = "nugget.obj",
            tiles = {"1042_"..name.."_nugget.png"},
            --tiles = {"1042_plain_node.png^[colorize:#ddaa22:128"},
            use_texture_alpha = "opaque",
        
        
            selection_box = {
                type = "fixed",
                fixed = {-0.1, -0.5, -0.1, 0.1, -0.3, 0.1}
            },
            collision_box = {
                type = "fixed",
                fixed = {-0.1, -0.5, -0.1, 0.1, -0.3, 0.1}
            },
            
            sounds = {
                dug = {
                    name = "stone_dig",
                    gain = 0.2,
                    pitch = 1
                },
                place = {
                    name = "stone_walk",
                    gain = 0.5,
                    pitch = 1.5
                }
            },
        
            _1042_moldable = {texture = "1042_"..name.."_ingot.png", name = name, drop = "1042_core:"..name.."_ingot"},
        
            paramtype = "light",
            paramtype2 = "4dir",
            sunlight_propagates = true,
            walkable = true,
            buildable_to = false,
            
            groups = {dig_immediate = 1, attached_node = 3},
        
            item_type = "node",
        }, math.max(rarity-1, 1), nil, {name = "1042_core:"..name.."_nugget", max_count = 9})
    end
end

register_metal("copper", function() end, true, 1)
register_metal("bronze", function() end, false, 2)
register_metal("iron", hit_flint_with_iron, true, 3)
register_metal("steel", hit_flint_with_iron, false, 3)
register_metal("gold", function() end, true, 4)
register_metal("silver", function() end, true, 4)
register_metal("cobalt", function() end, true, 5)
register_metal("titanium", function() end, true, 5)

core_1042.registry.register_material("1042_core:pork_raw", {
    description = core_1042.lorelang.translate("Raw Pork"),
    drawtype = "mesh",
    mesh = "pork.obj",
    tiles = {"1042_pork_raw1.png", "1042_pork_raw1.png", "1042_pork_raw1.png"},
    --tiles = {
    --    "1042_plain_node.png^[colorize:#ffbb88:128",
    --    "1042_plain_node.png^[colorize:#ffaa77:144",
    --    "1042_plain_node.png^[colorize:#ff9966:128"
    --},
    use_texture_alpha = "opaque",

    paramtype = "light",
    paramtype2 = "facedir",
    sunlight_propagates = true,
    walkable = true,
    buildable_to = false,
    
    _1042_on_use = function(itemstack, user)
        return core_1042.eat(itemstack, user, 4, 2)
    end,

    _1042_cooks_to = "1042_core:pork_cooked",

    _1042_campfire_cooks = {
		hanging = true,
		name = "pork",
		drop = "1042_core:pork_cooked",
		model = "cooking_pork.obj",
		textures = {
			"1042_pork_cooking.png",
			"1042_pork_cooking.png",
			"1042_pork_cooking.png",
			"1042_pork_cooking.png"
		}
	},

    groups = {food = 1, dig_immediate = 1, attached_node = 3, cooks = 3},

    item_type = "node",
}, 2, nil, nil)

core_1042.registry.register_material("1042_core:pork_cooked", {
    description = core_1042.lorelang.translate("Cooked Pork"),
    drawtype = "mesh",
    mesh = "pork.obj",
    tiles = {"1042_pork_cooked.png", "1042_pork_cooked.png", "1042_pork_cooked.png"},
    --tiles = {
    --    "1042_plain_node.png^[colorize:#dd4422:128",
    --    "1042_plain_node.png^[colorize:#cc3311:144",
    --    "1042_plain_node.png^[colorize:#993322:128"
    --},
    use_texture_alpha = "opaque",

    paramtype = "light",
    paramtype2 = "facedir",
    sunlight_propagates = true,
    walkable = true,
    buildable_to = false,
    
    _1042_on_use = function(itemstack, user)
        return core_1042.eat(itemstack, user, 8, nil)
    end,


    groups = {food = 1, dig_immediate = 1, attached_node = 3},

    item_type = "node",
}, 2, nil, nil)

core_1042.registry.register_material("1042_core:spyglass", {
    description = core_1042.lorelang.translate("Spyglass"),
    drawtype = "mesh",
    mesh = "spyglass.obj",
    tiles = {"1042_tree.png", "1042_gold_ingot.png", "1042_glass.png"},
    use_texture_alpha = "opaque",

    paramtype = "light",
    paramtype2 = "facedir",
    sunlight_propagates = true,
    walkable = true,
    buildable_to = false,
    _1042_aux = {
        mode = "selection",
        num = 9,
        func = function(player, zoom)
            player:set_fov(100 - (zoom * 10), false)
        end,
        done_func = function(player, zoom)
            player:set_fov(100, false)
        end,
    },
    stack_max = 1,

    groups = {dig_immediate = 1, attached_node = 3},

    item_type = "node",
}, 3, nil, nil)

core_1042.register_loot({name = "1042_core:spyglass"})
core_1042.crafting.register_craft({
    result = "1042_core:spyglass",
    type = "1042_default",
    items = {
        "1042_core:gold_ingot", "1042_core:tree", "1042_core:glass"
    }
})

core_1042.registry.register_material("1042_core:glider", {
    description = core_1042.lorelang.translate("Glider"),
    drawtype = "mesh",
    mesh = "glider_node.obj",
    tiles = {"1042_tree.png", "1042_thin_moss.png"},
    use_texture_alpha = "blend",

    paramtype = "light",
    paramtype2 = "facedir",
    sunlight_propagates = true,
    walkable = true,
    buildable_to = false,
    stack_max = 1,

    groups = {glider = 1, dig_immediate = 1, attached_node = 3},
    on_secondary_use = function(itemstack, user, pointed_thing)
        local inv = user:get_inventory()
        local glider_slot = inv:get_stack("glider", 1):get_name()
        if glider_slot ~= "1042_core:glider" then
            inv:set_stack("glider", 1, ItemStack("1042_core:glider"))
            return ItemStack()
        end
        return itemstack
    end,
    --[[
    on_use = function(itemstack, player, pointed_thing)
        local p_pos = player:get_pos()
        local node_below = core.get_node({x = p_pos.x, y = p_pos.y - 0.5, z = p_pos.z})
        local def = core.registered_nodes[node_below.name]

        if not def.walkable then
            local name = player:get_player_name()
            if (core_1042.get(name .. "_gliding") == "off") then
                core_1042.set(name .. "_gliding", "on")
                core_1042.set(name .. "_gliding_physics_backup", player:get_physics_override())
            else
                core_1042.set(name .. "_gliding", "off")
				local p = core_1042.get(name .. "_gliding_physics_backup")
				if not p then
					player_api.set_physics(player)
				else
					player:set_physics_override(p)
				end
                player:set_bone_override("Spine", nil)
            end
        end
    end,
    ]]

    item_type = "item",
}, 3, {
    result = "1042_core:glider",
    type = "1042_default",
    items = {
        "group:plant 6", "1042_core:sticks 4"
    }
}, {name = "1042_core:glider"})

core.register_entity("1042_core:glider_entity", {
    initial_properties = {
        hp_max = 100,
        collide_with_objects = false,
        pointable = false,
        visual = "mesh",
        visual_size = {x = 2, y = 2, z = 2},
        mesh = "glider.obj",
        textures = {"1042_tree.png", "1042_thin_moss.png"},
        use_texture_alpha = true,
        backface_culling = false,
    },
    on_detach = function(self, parent)
        if self.object ~= nil then
            self.object:remove()
        end
    end,
})