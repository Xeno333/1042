
core.register_item(":", {
	type = "none",
	wield_image = "1042_plain_node.png^[colorize:#a9a347:128",
    range = 4.0,
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
        name = "game",
        text = "1042",
        position = {x=0.98, y=0.02},
        number = 0x00ffff,
        style = 3
    })

end)


core.register_globalstep(function(dtime)
    for _, player in ipairs(core.get_connected_players()) do
        local metaref = player:get_meta()
        local id = metaref:get_int("pointed_node")


        if id ~= 0 then 
            player:hud_remove(id)
            metaref:set_int("pointed_node", 0)
        end

        local pos = player:get_pos()
        pos.y = pos.y + player:get_properties().eye_height
        local ray = core.raycast(vector.new(pos.x, pos.y, pos.z), vector.add(vector.new(pos.x, pos.y, pos.z), vector.multiply(player:get_look_dir(), 4)), false, false)

        local node = ray:next()
        if node and node.type == "node" then
            local txt = core.registered_nodes[core.get_node(vector.new(node.under.x, node.under.y, node.under.z)).name].description
            if txt then 
                metaref:set_int("pointed_node", player:hud_add({
                    type = "text",
                    name = "pointed_node_hud",
                    text = txt,
                    position = {x=0.5, y=0.05},
                    number = 0x00ffdd,
                    style = 3
                }))
            end
        end


    end
end)