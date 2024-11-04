
core.register_item(":", {
	type = "none",
	wield_image = "1042_plain_node.png^[colorize:#a9a347:128",
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level = 1,
		groupcaps = {
			breakable_by_hand = {times = {[1] = 0.25, [2] = 0.5, [3] = 1, [4] = 2, [5] = 3, [6] = 4}, uses = 0},

            -- Debug
			stone = {times = {[1] = 0.25, [2] = 0.5, [3] = 1, [4] = 2, [5] = 3, [6] = 4}, uses = 0},
			wood = {times = {[1] = 0.25, [2] = 0.5, [3] = 1, [4] = 2, [5] = 3, [6] = 4}, uses = 0},
		},
		damage_groups = {fleshy = 1},
	},
    groups = {not_in_creative_inventory = 1}
})


-- Join player

core.register_on_joinplayer(function(player, last_join)
    player:set_properties({
        show_on_minimap = false,
    })

    player:set_physics_override(
        {
            gravity = 1.5,
            jump = 1.2,
            sneak_glitch = true
        }
    )   

    player:hud_set_flags(
        {
            crosshair = false,
            minimap = false,
            minimap_radar = false,
        }
    )
end)
