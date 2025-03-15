-- Inv



-- Load gameplay.md
local fn = core_1042.info.path .. "/docs/gameplay.md"
local gamplay_md = core_1042.read_file(fn)

if not gamplay_md then
    error("Could not open \"" .. fn .. "\", this is needed for gameplay!")
end

-- Load README.md
fn = core_1042.info.path .. "/README.md"
local README_md = core_1042.read_file(fn)

if not README_md then
    error("Could not open \"" .. fn .. "\", this is needed for gameplay!")
end

-- Load LICENSE
fn = core_1042.info.path .. "/LICENSE"
local LICENSE = core_1042.read_file(fn)

if not LICENSE then
    error("Could not open \"" .. fn .. "\", this is needed for gameplay!")
end

-- Load credits.txt
fn = core_1042.info.path .. "/credits.txt"
local credits_txt = core_1042.read_file(fn)

if not credits_txt then
    error("Could not open \"" .. fn .. "\", this is needed for gameplay!")
end






function core_1042.make_inv_formspec(player)
    local greyscale = core_1042.get("playersetting_"..player:get_player_name().."_greyscale") or "false"
    local hud_at_bottom = core_1042.get("playersetting_"..player:get_player_name().."_hud_at_bottom") or "false"
    local show_creative = core_1042.is_creative(player)
    local hide_creative_inv = "false"
    local position = "0.53,0.5"

    if hud_at_bottom == "true" then
        position = "0.5,0.48"
    end

    local craft_count = core.get_inventory({type="detached", name=player:get_player_name() .. "_crafts"}):get_size("main")

    local inv_formspec = 
        "formspec_version[8]size[32,17.5,false]position["..position.."]style_type[*;sound=stone_dig]"..
        "scrollbaroptions[arrows=hide]"..
        "listcolors[#00ffff40;#00ffff80;#00aaaaff;#00444480;#00ffffff]"..
        "bgcolor[#00223320;;]"..
        "set_focus[leave_game;true]"..
        "image_button[29,0.3;2.7,1;1042_plain_node.png^[colorize:#ff2200:144;leave_game;Leave Game]"..

        "model[13,-2.2;4,4;logo;1042.obj;1042_plain_node.png^[colorize:#672307:168;0,90;true;true;;]"..

        "label[1.5,1.5;Settings]"..
        "scroll_container[2,2;28,4;setting_box_scrollbar;vertical;0.1;true]"..

            "checkbox[0,0.5;setting_greyscale;Greyscale;"..greyscale.."]"

            if show_creative then
                hide_creative_inv = core_1042.get("playersetting_"..player:get_player_name().."_hide_creative_inv") or "false"
                inv_formspec = inv_formspec..
                "checkbox[0,1;setting_hide_creative_inv;Hide creative inv;"..hide_creative_inv.."]"
            end

            inv_formspec = inv_formspec..
            "checkbox[0,1.5;setting_hud_at_bottom;Hud at bottom;"..hud_at_bottom.."]"..
            --"label[0,2.5;HUD Stats]"..
            --"checkbox[1,3;setting_hud_stats_default;Enable default HUD stats;false]"..
            --"checkbox[1,3.5;setting_hud_stats_default;Enable advanced HUD stats;false]"..

        "scroll_container_end[]"..
        "scrollbar[1,2;0.5,4;vertical;setting_box_scrollbar;0]"..

        "label[1.5,7.5;Docs]"..
        "image_button[2,8;2,1;1042_plain_node.png^[colorize:#22ff44:144;doc_gameplay_md;Guide]"..
        "image_button[5,8;2,1;1042_plain_node.png^[colorize:#22ffff:144;README_md;README]"..
        "image_button[8,8;2,1;1042_plain_node.png^[colorize:#88ffff:144;LICENSE;©]"..
        "image_button[11,8;2,1;1042_plain_node.png^[colorize:#448888:144;credits_txt;Credits]"..

        "list[current_player;main;1,11;10,4;]"..
        "listring[current_player;main]"

        if craft_count > 0 then
            inv_formspec = inv_formspec..
            "scroll_container[15,11;10,5;craft;vertical;0.1;true]"..
            "list[detached:" .. player:get_player_name() .. "_crafts;main;0,0;4," .. craft_count / 4 + ((craft_count % 4 > 0) and 1 or 0) .. ";]"..
            "listring[detached:" .. player:get_player_name() .. "_crafts;main]"..
            "listring[current_player;main]"..
            "scroll_container_end[]"..
            "scrollbar[14.3,11;0.5,5;vertical;craft;0]"
        end
        
        inv_formspec = inv_formspec..
        "list[detached:void;main;1,16;1,1;]"..
        "image[1.4,16.4;0.25,0.25;1042_plain_node.png^[colorize:#ff2200:144]"


    if show_creative and hide_creative_inv ~= "true" then
        local size = core_1042.creative_inv:get_size("main")

        inv_formspec = inv_formspec ..
            "scroll_container[21,11;10,5;creative_inv;vertical;0.1;true]"..
            "list[detached:creative;main;0.1,0.1;8," .. (size / 8) + ((size % 8 > 0) and 1 or 0) .. ";]"..
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

            local id = core_1042.player_huds[player:get_player_name()].hotbar
            if fields.setting_hud_at_bottom == "true" then
                player:hud_change(id, "direction", 0)
                player:hud_change(id, "position", {x=0.5, y=0.95})

            else
                player:hud_change(id, "direction", 2)
                player:hud_change(id, "position", {x=0.05, y=0.5})

            end

            player:set_inventory_formspec(core_1042.make_inv_formspec(player))

        elseif fields.setting_hide_creative_inv then
            core_1042.set("playersetting_"..player:get_player_name().."_hide_creative_inv", fields.setting_hide_creative_inv)
            player:set_inventory_formspec(core_1042.make_inv_formspec(player))

        elseif fields.doc_gameplay_md then
            core.show_formspec(player:get_player_name(), "doc_gameplay_md", "formspec_version[8]size[14,9,false]textarea[0,0;14,9;gameplay_md_text;;" .. core.formspec_escape(gamplay_md) .. "]")

        elseif fields.README_md then
            core.show_formspec(player:get_player_name(), "README_md", "formspec_version[8]size[14,9,false]textarea[0,0;14,9;README_md_text;;" .. core.formspec_escape(README_md) .. "]")
            
        elseif fields.LICENSE then
            core.show_formspec(player:get_player_name(), "LICENSE", "formspec_version[8]size[14,9,false]textarea[0,0;14,9;LICENSE_text;;" .. core.formspec_escape(LICENSE) .. "]")

        elseif fields.credits_txt then
            core.show_formspec(player:get_player_name(), "credits_txt", "formspec_version[8]size[14,9,false]textarea[0,0;14,9;credits_txt_text;;" .. core.formspec_escape(credits_txt) .. "]")

        end
    end
end)







core.register_on_joinplayer(function(player)
    player:set_inventory_formspec(core_1042.make_inv_formspec(player))
end)