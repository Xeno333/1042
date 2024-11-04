



-- Land Nodes

core.register_node("1042_nodes:dirt", {
    description = "Dirt",
    tiles = {"1042_plain_node.png^[colorize:#8B4513:128"},
    use_texture_alpha = "opaque",

    groups = {dirt = 1, breakable_by_hand = 2},
})

core.register_node("1042_nodes:sand", {
    description = "Sand",
    tiles = {"1042_plain_node.png^[colorize:#d9a357:128"},
    use_texture_alpha = "opaque",

    groups = {dirt = 1, falling_node = 1, breakable_by_hand = 1},
})

core.register_node("1042_nodes:snow", {
    description = "Snow",
    tiles = {"1042_plain_node.png^[colorize:#ffffff:168"},
    use_texture_alpha = "opaque",

    groups = {snow = 1, falling_node = 1, melts = 1, breakable_by_hand = 1},
})

core.register_node("1042_nodes:ice", {
    description = "Ice",
    drawtype = "glasslike",
    tiles = {"1042_plain_node.png^[colorize:#bbbbff:72"},
    use_texture_alpha = "blend",
	paramtype = "light",

    groups = {falling_node = 1, float = 1, melts = 1, slippery = 3},
})

core.register_node("1042_nodes:turf", {
    description = "Turf",
    tiles = {"1042_plain_node.png^[colorize:#278b13:168"},
    use_texture_alpha = "opaque",

    groups = {dirt = 1, breakable_by_hand = 1},
})

core.register_node("1042_nodes:stone", {
    description = "Stone",
    tiles = {"1042_plain_node.png^[colorize:#777777:128"},
    use_texture_alpha = "opaque",

    groups = {stone = 1},
})




-- Plant Nodes


core.register_node("1042_nodes:leaves_plain", {
    description = "Plain Leaves",
    tiles = {"1042_plain_node.png^[colorize:#1c770a:168"},
    use_texture_alpha = "blend",
    drawtype = "allfaces",
    
    paramtype = "light",
    sunlight_propagates = true,

    groups = {leaves = 1, plant = 1, breakable_by_hand = 1, burns = 1},
})

core.register_node("1042_nodes:tree", {
    description = "Tree",
    tiles = {"1042_plain_node.png^[colorize:#672307:200"},
    use_texture_alpha = "opaque",

    groups = {wood = 1, plant = 1, burns = 1},
})






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

    groups = {plant = 1, attached_node = 3, breakable_by_hand = 1, burns = 1},
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

    groups = {plant = 1, attached_node = 3, breakable_by_hand = 1, burns = 1},
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

    groups = {plant = 1, attached_node = 3, breakable_by_hand = 1, burns = 1},
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
    floodable = true,
    walkable = true,
    buildable_to = false,
    
    on_use = function(itemstack, user, pointed_thing)
        return core_1042.eat(itemstack, user, pointed_thing, 1)
    end,

    groups = {plant = 1, food = 1, breakable_by_hand = 1},
})





-- Speacal nodes

core.register_node("1042_nodes:amethyst", {
    description = "Amethyst",
    drawtype = "mesh",
    mesh = "crystal.obj",
    tiles = {"1042_plain_node.png^[colorize:#aa66aa:128"},
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

    light_source = 4,
    
    groups = {breakable_by_hand = 2, attached_node = 3},
})

core.register_node("1042_nodes:rock", {
    description = "Rock",
    drawtype = "mesh",
    mesh = "rock.obj",
    tiles = {"1042_plain_node.png^[colorize:#777777:128"},
    use_texture_alpha = "opaque",


    selection_box = {
        type = "fixed",
        fixed = {-0.4, -0.5, -0.4, 0.4, -0.2, 0.4}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.4, -0.5, -0.4, 0.4, -0.2, 0.4}
    },

    paramtype = "light",
    paramtype2 = "4dir",
    sunlight_propagates = true,
    walkable = true,
    buildable_to = false,
    
    groups = {breakable_by_hand = 2, attached_node = 3},
})


core.register_node("1042_nodes:sticks", {
    description = "Sticks",
    drawtype = "mesh",
    mesh = "sticks.obj",
    tiles = {"1042_plain_node.png^[colorize:#672307:172"},
    use_texture_alpha = "opaque",

    paramtype = "light",
    sunlight_propagates = true,
    floodable = true,
    walkable = false,
    buildable_to = false,
    
    groups = {breakable_by_hand = 1, attached_node = 3, burns = 1},
})


core.register_node("1042_nodes:fire_pile", {
    description = "Fire Pile",
    drawtype = "mesh",
    mesh = "fire_pile.obj",
    tiles = {"1042_plain_node.png^[colorize:#672307:172"},
    use_texture_alpha = "opaque",

    paramtype = "light",
    sunlight_propagates = true,
    floodable = true,
    walkable = false,
    buildable_to = false,
    
    groups = {breakable_by_hand = 1, attached_node = 3, burns = 1},
})

--[[
core.register_abm({
    interval = 4,
    chance = 1,
    nodenames = {"1042_nodes:fire_pile"},
    action = function(pos, node, active_object_count, active_object_count_wider)
        core.add_particlespawner({
            amount = 128,
            time = 4,

            collisiondetection = true,
            object_collision = true,

            vel = {
                min = vector.new(-1, 0.5, -1),
                max = vector.new(1, 2, 1),
                bias = 0
            },

            acc = vector.new(0, 1, 0),

            size = {
                min = 0.5,
                max = 1
            },

            exptime = {
                min = 0.2,
                max = 0.5
            },

            bounce = {
                min = 0,
                max = 0.3
            },

            glow = 14,

            pos = {
                min = vector.new(pos.x-0.3,pos.y-0.5,pos.z-0.3),
                max = vector.new(pos.x+0.3,pos.y,pos.z+0.3),
                bias = 0
            },

            texture = "1042_plain_node.png^[colorize:#ff0000:144"
        })
    end
})]]


-- Liquids

core.register_node("1042_nodes:water_source", {
    description = "Water Source",

    drawtype = "liquid",
    tiles = {
		{
			name = "1042_plain_node.png^[colorize:#00bbcc:144",
			backface_culling = false,
		},
		{
			name = "1042_plain_node.png^[colorize:#00bbcc:144",
			backface_culling = true,
		},
    },
	use_texture_alpha = "blend",
    
    paramtype = "light",
    paramtype2 = "none",
    light_source = 4,

    walkable = false,
    pointable = false,
    diggable = false,
    buildable_to = true,
    is_ground_content = false,


    liquidtype = "source",
    liquid_alternative_flowing = "1042_nodes:water_flowing",
    liquid_alternative_source = "1042_nodes:water_source",

    drowning = 2,
    liquid_viscosity = 1,
    liquid_range = 5,
	waving = 3,

    post_effect_color = {a = 64, r = 0x00, g = 0xbb, b = 0xcc},
    groups = {water = 1, liquid = 1},

})

core.register_node("1042_nodes:water_flowing", {
    description = "Flowing Water",

    drawtype = "flowingliquid",
    tiles = {"1042_plain_node.png^[colorize:#00bbcc:144"},
    special_tiles = {
		{
			name = "1042_plain_node.png^[colorize:#00bbcc:144",
			backface_culling = false,
		},
		{
			name = "1042_plain_node.png^[colorize:#00bbcc:144",
			backface_culling = true,
		},
    },
	use_texture_alpha = "blend",

    paramtype = "light",
    paramtype2 = "flowingliquid",
    light_source = 4,

    walkable = false,
    pointable = false,
    diggable = false,
    buildable_to = true,
    is_ground_content = false,

    liquidtype = "flowing",
    liquid_alternative_flowing = "1042_nodes:water_flowing",
    liquid_alternative_source = "1042_nodes:water_source",

    drowning = 2,
    liquid_viscosity = 1,
    liquid_range = 5,
	waving = 3,

    post_effect_color = {a = 64, r = 0x00, g = 0xbb, b = 0xcc},
    groups = {water = 1, liquid = 1},
})






core.register_node("1042_nodes:lava_source", {
    description = "Lava Source",

    drawtype = "liquid",
    tiles = {
		{
			name = "1042_plain_node.png^[colorize:#ff2200:144",
			backface_culling = false,
		},
		{
			name = "1042_plain_node.png^[colorize:#ff2200:144",
			backface_culling = true,
		},
    },
	use_texture_alpha = "none",
    
    paramtype = "light",
    paramtype2 = "none",
    sunlight_propagates = true,
    light_source = 6,

    walkable = false,
    pointable = false,
    diggable = false,
    buildable_to = true,
    is_ground_content = false,


    liquidtype = "source",
    liquid_alternative_flowing = "1042_nodes:lava_flowing",
    liquid_alternative_source = "1042_nodes:lava_source",

    drowning = 10,
    liquid_viscosity = 4,
    liquid_range = 4,

    post_effect_color = {a = 144, r = 0xff, g = 0x22, b = 0x00},
    groups = {lava = 1, liquid = 1},

})

core.register_node("1042_nodes:lava_flowing", {
    description = "Flowing Lava",

    drawtype = "flowingliquid",
    tiles = {"1042_plain_node.png^[colorize:#ff2200:144"},
    special_tiles = {
		{
			name = "1042_plain_node.png^[colorize:#ff2200:144",
			backface_culling = false,
		},
		{
			name = "1042_plain_node.png^[colorize:#ff2200:144",
			backface_culling = true,
		},
    },
	use_texture_alpha = "none",
    
    paramtype = "light",
    paramtype2 = "none",
    sunlight_propagates = true,
    light_source = 6,

    walkable = false,
    pointable = false,
    diggable = false,
    buildable_to = true,
    is_ground_content = false,

    liquidtype = "flowing",
    liquid_alternative_flowing = "1042_nodes:lava_flowing",
    liquid_alternative_source = "1042_nodes:lava_source",

    drowning = 10,
    liquid_viscosity = 4,
    liquid_range = 4,

    post_effect_color = {a = 144, r = 0xff, g = 0x22, b = 0x00},
    groups = {lava = 1, liquid = 1},
})

