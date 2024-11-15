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
    local items_to_reg = {}

    for _, list in ipairs(lists) do
        for name, def in pairs(list) do
            if not added[name] then
                added[name] = true
                if not def.groups.not_in_creative_inventory then
                    size = size + 1
                    items_to_reg[#items_to_reg+1] = def
                end
            end
        end
    end

    table.sort(items_to_reg, function(a, b)
        return a.name > b.name
    end)

    inv:set_size("main", size)
    for i, def in ipairs(items_to_reg) do
        local is = ItemStack(def.name)
        is:set_count(def.stack_max)
        inv:set_stack("main", i, is)
    end
    

    inv_row_count = (size / 8)
    if size % 8 > 0 then
        inv_row_count = inv_row_count + 1
    end

    -- Void

    local void = core.create_detached_inventory("void",
        {
            allow_move = function() return 0 end,
            allow_put = function() return -1 end,
            allow_take = function() return 0 end,
        })
        
    void:set_size("main", 1)


end)



function core_1042.make_inv_formspec(player)
    local greyscale = core_1042.get("playersetting_"..player:get_player_name().."_greyscale") or "false"
    local hud_at_bottom = core_1042.get("playersetting_"..player:get_player_name().."_hud_at_bottom") or "false"
    local show_creative = core_1042.is_creative(player)
    local hide_creative_inv = "false"
    local position = "0.53,0.5"

    if hud_at_bottom == "true" then
        position = "0.5,0.48"
    end

    local inv_formspec = 
        "formspec_version[8]size[32,17,false]position["..position.."]"..

        "model[13,-2.2;4,4;logo;1042.obj;1042_plain_node.png^[colorize:#672307:168;0,90;true;true;;]"..
        "image_button[29,0.3;2.7,1;1042_plain_node.png^[colorize:#ff2200:144;leave_game;Leave Game]"..
        "set_focus[leave_game;false]"..

        "label[1.5,1.5;Settings]"..
        "scroll_container[2,2;28,4;setting_box_scrollbar;vertical;0.1;true]"..

            "checkbox[0,0.5;setting_greyscale;Greyscale;"..greyscale.."]"..
            "checkbox[0,1.5;setting_hud_at_bottom;Hud at bottom;"..hud_at_bottom.."]"

            if show_creative then
                hide_creative_inv = core_1042.get("playersetting_"..player:get_player_name().."_hide_creative_inv") or "false"
                inv_formspec = inv_formspec..
                "checkbox[0,1;setting_hide_creative_inv;Hide creative inv;"..hide_creative_inv.."]"
            end

        inv_formspec = inv_formspec..
        "scroll_container_end[]"..
        "scrollbar[1,2;0.5,4;vertical;setting_box_scrollbar;0]"..

        "list[current_player;main;1,11;10,4;]"..
        "listring[current_player;main]"..
        "listring[current_player;craft]"..
        "listring[current_player;main]"..
        
        "list[detached:void;main;18.5,14;1,1;]"..
        "image[18.9,14.4;0.25,0.25;1042_plain_node.png^[colorize:#ff2200:144]"..

        "list[current_player;craft;14.5,11.5;3,3;]"..
        "list[current_player;craftpreview;18.5,11.5;1,1;]"..
        "image[18.9,11.9;0.25,0.25;1042_plain_node.png^[colorize:#22ff00:144]"


    if show_creative and hide_creative_inv ~= "true" then
        inv_formspec = inv_formspec ..
        "scroll_container[21,11;10,5;creative_inv;vertical;0.1;true]"..

            "list[detached:creative;main;0,0;8," .. inv_row_count .. ";]"..
            "listring[detached:creative;main]"..
            "lstring[current_player;main]"..

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

        elseif fields.setting_hud_at_bottom then
            core_1042.set("playersetting_"..player:get_player_name().."_hud_at_bottom", fields.setting_hud_at_bottom)

            local hotbar = {
                type = "hotbar",
                name = "hotbar",
                text = "main",
            }
            if fields.setting_hud_at_bottom == "true" then
                hotbar.direction = 0
                hotbar.position = {x=0.5, y=0.95}
            else
                hotbar.direction = 2
                hotbar.position = {x=0.05, y=0.5}
            end
            core.hud_replace_builtin("hotbar", hotbar)

            player:set_inventory_formspec(core_1042.make_inv_formspec(player))

        elseif fields.setting_hide_creative_inv then
            core_1042.set("playersetting_"..player:get_player_name().."_hide_creative_inv", fields.setting_hide_creative_inv)
            player:set_inventory_formspec(core_1042.make_inv_formspec(player))
        end
    end
end)



core.register_on_joinplayer(function(player)
    local inv = player:get_inventory()
    inv:set_size("main", 40)
    inv:set_size("craft", 9)

    player:set_inventory_formspec(core_1042.make_inv_formspec(player))
end)