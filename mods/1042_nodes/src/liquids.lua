
-- Liquids

core.register_node("1042_nodes:water_source", {
    description = "Water Source",

    drawtype = "liquid",
    tiles = {
		{
			name = "water.png^[makealpha:1,1,1",
			backface_culling = false,
		},
		{
			name = "water.png^[makealpha:1,1,1",
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

    sounds = {
        footstep = {
            name = "water",
            gain = 0.5,
            pitch = 1
        },
    },

    liquidtype = "source",
    liquid_alternative_flowing = "1042_nodes:water_flowing",
    liquid_alternative_source = "1042_nodes:water_source",
    drop = "",

    drowning = 2,
    liquid_viscosity = 1,
    liquid_range = 5,
	waving = 3,

    post_effect_color = {a = 64, r = 0x00, g = 0x6e, b = 0xa9},
    groups = {water = 1, liquid = 1, cools = 1},
})

core.register_node("1042_nodes:water_flowing", {
    description = "Flowing Water",

    drawtype = "flowingliquid",
    tiles = {"water.png"},
    special_tiles = {
		{
			name = "water.png^[makealpha:1,1,1",
			backface_culling = false,
		},
		{
			name = "water.png^[makealpha:1,1,1",
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

    sounds = {
        footstep = {
            name = "water",
            gain = 0.5,
            pitch = 1
        },
    },

    liquidtype = "flowing",
    liquid_alternative_flowing = "1042_nodes:water_flowing",
    liquid_alternative_source = "1042_nodes:water_source",
    drop = "",

    drowning = 2,
    liquid_viscosity = 1,
    liquid_range = 5,
	waving = 3,

    post_effect_color = {a = 64, r = 0x00, g = 0x6e, b = 0xa9},
    groups = {water = 1, liquid = 1, cools = 1, not_in_creative_inventory = 1},
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
    drop = "",

    drowning = 10,
    liquid_viscosity = 4,
    liquid_range = 4,
    damage_per_second = 10,

    _1042_cools_to = "1042_nodes:basalt",
    post_effect_color = {a = 144, r = 0xff, g = 0x22, b = 0x00},
    groups = {molten = 1, liquid = 1, burning = 1},

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
    _1042_cools_to = "1042_nodes:basalt",
    diggable = false,
    buildable_to = true,
    is_ground_content = false,

    liquidtype = "flowing",
    liquid_alternative_flowing = "1042_nodes:lava_flowing",
    liquid_alternative_source = "1042_nodes:lava_source",
    drop = "",

    drowning = 10,
    liquid_viscosity = 4,
    liquid_range = 4,
    damage_per_second = 10,

    _1042_cools_to = "1042_nodes:basalt",
    post_effect_color = {a = 144, r = 0xff, g = 0x22, b = 0x00},
    groups = {molten = 1, liquid = 1, burning = 1, not_in_creative_inventory = 1},
})







core.register_node("1042_nodes:molten_iron_source", {
    description = "Molten Iron Source",

    drawtype = "liquid",
    tiles = {
		{
			name = "1042_plain_node.png^[colorize:#cc3300:144",
			backface_culling = false,
		},
		{
			name = "1042_plain_node.png^[colorize:#cc3300:144",
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
    liquid_alternative_flowing = "1042_nodes:molten_iron_flowing",
    liquid_alternative_source = "1042_nodes:molten_iron_source",
    drop = "",

    drowning = 10,
    liquid_viscosity = 10,
    liquid_range = 1,
    damage_per_second = 10,

    _1042_cools_to = "1042_nodes:iron_slag",
    post_effect_color = {a = 144, r = 0xff, g = 0x22, b = 0x00},
    groups = {molten = 1, liquid = 1, burning = 1},

})

core.register_node("1042_nodes:molten_iron_flowing", {
    description = "Flowing Molten Iron",

    drawtype = "flowingliquid",
    tiles = {"1042_plain_node.png^[colorize:#cc3300:144"},
    special_tiles = {
		{
			name = "1042_plain_node.png^[colorize:#cc3300:144",
			backface_culling = false,
		},
		{
			name = "1042_plain_node.png^[colorize:#cc3300:144",
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
    liquid_alternative_flowing = "1042_nodes:molten_iron_flowing",
    liquid_alternative_source = "1042_nodes:molten_iron_source",
    drop = "",

    drowning = 10,
    liquid_viscosity = 10,
    liquid_range = 1,
    damage_per_second = 10,

    _1042_cools_to = "1042_nodes:iron_slag",
    post_effect_color = {a = 144, r = 0xff, g = 0x22, b = 0x00},
    groups = {molten = 1, liquid = 1, burning = 1, not_in_creative_inventory = 1},
})
