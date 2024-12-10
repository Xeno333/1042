core_1042.player_huds = {}
local  player_huds = core_1042.player_huds
local aux1_cooldown = {}






core.override_item("", {
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



-- Spawn player

local function spawn_player(player)
    local pos = nil

    while pos == nil do
        local x = math.random(0, 20000)
        local z = math.random(0, 20000)
        local y = mapgen_1042.get_spawn_y(x, z) 

        if y then
            pos = vector.new(x, y+1, z)
            break
        end
    end

    player:set_pos(pos)

    return true
end

core.register_on_respawnplayer(spawn_player)


-- Die player

core.register_on_dieplayer(function(player, reason)
    local inv = player:get_inventory()
    local pos = player:get_pos()

    for listname, list in pairs(inv:get_lists()) do
        for i, itemstack in ipairs(list) do
            core.item_drop(itemstack, player, pos)
            inv:set_stack(listname, i, ItemStack(""))
        end
    end
end)






-- Join player

core.register_on_joinplayer(function(player, last_join)
    local name = player:get_player_name()

    player_huds[name] = {}
    aux1_cooldown[name] = 0

    player:set_properties({
        visual = "mesh",
        mesh = "player.gltf",
        textures = {
            "1042_plain_node.png^[colorize:#442211:168", -- Shoe
            "1042_plain_node.png^[colorize:#442211:144", -- Leg
            "1042_plain_node.png^[colorize:#442211:144", -- Leg
            "1042_plain_node.png^[colorize:#442211:200", -- Shoe
            "1042_plain_node.png^[colorize:#553311:168", -- Shirt
            "1042_plain_node.png^[colorize:#aa8877:144", -- Neck
            "1042_plain_node.png^[colorize:#aa8877:144",  -- Head
            "1042_plain_node.png^[colorize:#aa8877:144", -- Arm
            "1042_plain_node.png^[colorize:#aa8877:144"  -- Arm
        },
        show_on_minimap = false,
        visual_size = {
            x = 4,
            y = 4
        },
        stepheight = 1.1,

        nametag_color = "#00000000",
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
            basic_debug = false,
            hotbar = false -- We use custom one
        }
    )

    -- Ligthing and enviorment
    local saturation = 1.8
    if core_1042.get("playersetting_"..name.."_greyscale") == "true" then
        saturation = 0
    end

    player:set_lighting(
        {
            volumetric_light = {
                strength = 0.1
            },
            shadows = {
                intensity = 0.4,
                tint = {r=0x99, g=0x99, b=0x99}
            },
            bloom = {
                intensity = 0.07,
                strength_factor = 1.0,
                radius = 1.0
            },
            saturation = saturation,
            exposure = {
                exposure_correction = 0.75
            }
        }
    )
    player:set_moon(
        {
            texture = "1042_plain_node.png^[colorize:#aaaaaa:144",
            visible = true,
            scale = 0.3
        }
    )
    player:set_stars(
        {
            visible = true,
            day_opacity = 0.1,
            count = 6000,
            star_color = "#99aaffff",
            scale = 0.3
        }
    )

    local zoom_time = 0
    if last_join == nil then
        spawn_player(player)
        zoom_time = 1

        core.chat_send_player(name, core.colorize("#00ff00", "It is the year 1042 and you are lost."))
        
    else
        core.chat_send_player(name, "It is day " .. core.get_day_count() .. " of being lost.")

    end

    player:set_fov(100, false, zoom_time)







    -- Hud

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

    player_huds[name].hotbar = player:hud_add(hotbar)


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

    player:hud_set_hotbar_itemcount(10)
    player:hud_set_hotbar_image("1042_plain_node.png^[colorize:#00ffff:64")
    player:hud_set_hotbar_selected_image("1042_plain_node.png^[colorize:#00ffff:128")

end)





core.register_on_leaveplayer(function(player)
    local name = player:get_player_name()

    player_huds[name] = nil
    aux1_cooldown[name] = nil
end)






core.register_globalstep(function(dtime)
    for _, player in ipairs(core.get_connected_players()) do
        local name = player:get_player_name()
        local pointed_thing = core_1042.get_pointed_thing(player)
    
        if aux1_cooldown[name] > 0 then
            aux1_cooldown[name] = aux1_cooldown[name] - dtime
        end

        -- Controles
        local player_controls = player:get_player_control()
        local player_meta = player:get_meta()

        if player_controls.movement_y ~= 0 and player_meta:get_string("moving") == "false" then
            player:set_animation({x = 0, y = 40}, 3)
            player_meta:set_string("moving", "true")
        elseif player_controls.movement_y == 0 and player_meta:get_string("moving") ~= "false" then
            player:set_animation({x = 0, y = 0}, 1)
            player_meta:set_string("moving", "false")
        end


        -- _1042_use
        if player_controls.aux1 then
            local itemstack = player:get_wielded_item()
            local def = core.registered_items[itemstack:get_name()]

            if def._1042_on_use and aux1_cooldown[name] <= 0 then
                local ret_itemstack = def._1042_on_use(itemstack, player, pointed_thing)
                if ret_itemstack then
                    player:set_wielded_item(ret_itemstack)
                end
                aux1_cooldown[name] = 0.5
            end
        end




        -- Hud code

        local player_huds = player_huds[name]

        -- Pointed Item
        local id = player_huds.pointed_thing

        if id then 
            player:hud_remove(id)
            player_huds.pointed_thing = nil
        end

        if pointed_thing and pointed_thing.type == "node" then
            local txt = core.registered_nodes[core.get_node(vector.new(pointed_thing.under.x, pointed_thing.under.y, pointed_thing.under.z)).name].description
            if txt then 
                player_huds.pointed_thing =  player:hud_add({
                    type = "text",
                    name = "pointed_node_hud",
                    text = txt,
                    position = {x=0.5, y=0.05},
                    number = 0x00ffdd,
                    style = 3
                })
            end
        end


        -- Wield Item
        local wield_text = player_huds.wield_text

        if wield_text then
            player:hud_remove(wield_text)
            player_huds.wield_text = nil
        end

        local wield_item = player:get_wielded_item()
        if wield_item then
            local item = core.registered_items[wield_item:get_name()]
            if item and item.description then
                player_huds.wield_text = player:hud_add({
                    type = "text",
                    name = "wield_text_hud",
                    text = item.description,
                    position = {x=0.05, y=0.9},
                    number = 0x00ffdd,
                    style = 3
                })
            end
        end

    end
end)