
core.register_item(":", {
	type = "none",
	wield_image = "1042_plain_node.png^[colorize:#a9a347:128",
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level = 1,
		groupcaps = {
			breakable_by_hand = {times = {[1] = 0.25, [2] = 0.5, [3] = 1, [4] = 2, [5] = 3, [6] = 4}, uses = 0},
		},
		damage_groups = {fleshy = 1},
	},
    groups = {not_in_creative_inventory = 1}
})


-- Join player

core.register_on_joinplayer(function(player, last_join)
    player:set_properties({
        show_on_minimap = false,
        stepheight = 1.1
    })

    player:set_physics_override(
        {
            gravity = 1.5,
            jump = 1.2,
            sneak_glitch = true,
            liquid_sink = 2
        }
    )   

    player:hud_set_flags(
        {
            minimap = false,
            minimap_radar = false,
            crosshair = false,
            basic_debug = false
        }
    )





    -- Hud

    player:hud_set_hotbar_itemcount(10)
    player:hud_set_hotbar_image("1042_plain_node.png^[colorize:#00ffff:64")
    player:hud_set_hotbar_selected_image("1042_plain_node.png^[colorize:#00ffff:128")

    core.hud_replace_builtin("breath", {
        type = "statbar",
        name = "breath",
        text = "1042_plain_node.png^[colorize:#ddffff:168",
        text2 = "1042_plain_node.png^[colorize:#ddffff:64",
        number = 20,
        direction = 3,
        position = {x=0.98, y=0.6},
        size = {x=20,y=20}
    })
    
    core.hud_replace_builtin("health", {
        type = "statbar",
        name = "health",
        text = "1042_plain_node.png^[colorize:#ff0000:168",
        text2 = "1042_plain_node.png^[colorize:#ff0000:64",
        number = 20,
        direction = 3,
        position = {x=0.98, y=0.9},
        size = {x=20,y=20}
    })


    local hotbar = {
        type = "hotbar",
        name = "hotbar",
        text = "main",
    }
    if core_1042.get("playersetting_"..player:get_player_name().."_hud_at_bottom") == "true" then
        hotbar.direction = 0
        hotbar.position = {x=0.5, y=0.95}
    else
        hotbar.direction = 2
        hotbar.position = {x=0.05, y=0.5}
    end
    core.hud_replace_builtin("hotbar", hotbar)



    player:hud_add({
        type = "image",
        name = "pointer",
        text = "1042_plain_node.png^[colorize:#aaffff:128",
        position = {x=0.5, y=0.5},
        scale = {x=3,y=3},
    })

    player:hud_add({
        type = "text",
        name = "Game",
        text = "1042",
        position = {x=0.98, y=0.02},
        number = 0x00ffff,
        style = 3
    })

end)
