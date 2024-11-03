-- Inv

local inv_row_count = 0

core.register_on_mods_loaded(function()
    local inv = core.create_detached_inventory("creative",
        {
            allow_move = function() return 0 end,
            allow_put = function() return 0 end,
            allow_take = function() return -1 end,
        })

    local size = 0

    local lists = {core.registered_nodes, core.registered_items, core.registered_tools, core.registered_craftitems}

    local added = {}

    for _, list in ipairs(lists) do
        for name, def in pairs(list) do
            if not added[name] then
                added[name] = true
                if not def.groups.not_in_creative_inventory then
                    size = size + 1
                    inv:set_size("main", size)
                    local is = ItemStack(name)
                    is:set_count(99)
                    inv:set_stack("main", size, is)
                end
            end
        end
    end

    inv_row_count = (size / 8)
    if size % 8 > 0 then
        inv_row_count = inv_row_count + 1
    end

end)



function core_1042.make_inv_formspec(player)
    local greyscale = core_1042.get("playersetting_"..player:get_player_name().."_greyscale") or "false"
    local show_creative = core_1042.is_creative(player)
    local hide_creative_inv = "false"

    local inv_formspec = 
        "formspec_version[8]size[32,17,false]"..

        "model[13,-2.2;4,4;logo;1042.obj;1042_plain_node.png^[colorize:#672307:168;0,90;true;true;;]"..
        "image_button[29,0.3;2.7,1;1042_plain_node.png^[colorize:#ff2200:144;leave_game;Leave Game]"..
        "set_focus[leave_game;false]"..

        "label[1.5,1.5;Settings]"..
        "scroll_container[2,2;28,4;setting_box_scrollbar;vertical;0.1;true]"..

            "checkbox[0,0.5;setting_greyscale;Greyscale;"..greyscale.."]"

            if show_creative then
                hide_creative_inv = core_1042.get("playersetting_"..player:get_player_name().."_hide_creative_inv") or "false"
                inv_formspec = inv_formspec..
                "checkbox[0,1;setting_hide_creative_inv;Hide creative inv;"..hide_creative_inv.."]"
            end

        inv_formspec = inv_formspec..
        "scroll_container_end[]"..
        "scrollbar[1,2;0.5,4;vertical;setting_box_scrollbar;0]"..

        "list[current_player;main;1,11;8,4;]"

    if show_creative and hide_creative_inv ~= "true" then
        inv_formspec = inv_formspec ..
        "scroll_container[21,11;10,5;creative_inv;vertical;0.1;true]"..

            "list[detached:creative;main;0,0;8," .. inv_row_count .. ";]"..

        "scroll_container_end[]"..
        "scrollbar[20.3,11;0.5,5;vertical;creative_inv;0]"
    end

    return inv_formspec
end


core.register_on_player_receive_fields(function(player, form, fields)
    if form == "" then
        if fields.leave_game then
            core.disconnect_player(player:get_player_name(), "Thanks for playing!", true)

        elseif fields.setting_greyscale then
            core_1042.set("playersetting_"..player:get_player_name().."_greyscale", fields.setting_greyscale)
            
            if fields.setting_greyscale == "true" then
                player:set_lighting(
                    {
                        saturation = 0
                    }
                )
            else
                player:set_lighting(
                    {
                        saturation = 1.8
                    }
                )
            end
            player:set_inventory_formspec(core_1042.make_inv_formspec(player))

        elseif fields.setting_hide_creative_inv then
            core_1042.set("playersetting_"..player:get_player_name().."_hide_creative_inv", fields.setting_hide_creative_inv)
            player:set_inventory_formspec(core_1042.make_inv_formspec(player))
        end
    end
end)



core.register_on_joinplayer(function(player)
    local inv = player:get_inventory()
    inv:set_size("main", 32)

    player:set_inventory_formspec(core_1042.make_inv_formspec(player))
end)