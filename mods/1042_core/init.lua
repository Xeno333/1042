core_1042 = {}


local on_player_joins = {}

if core.settings:get("1042_auto_adjust_settings") == "true" then
    core.settings:set("enable_shaders", "true")
    core.settings:set("enable_post_processing", "true")
    core.settings:set("translucent_liquids", "true")
    core.settings:set("enable_3d_clouds", "true")
    core.settings:set("enable_auto_exposure", "true")

elseif core.settings:get("1042_ignore_required_settings") ~= "true" then
    if core.settings:get("enable_shaders") ~= "true" and core.is_singleplayer() then
        on_player_joins[#on_player_joins+1] = function(player)
            core.kick_player(player:get_player_name(), "Enable shaders to play this game!\n\nYou can also turn on the setting 1042>1042_auto_adjust_settings.")
        end
    end

    if core.settings:get("enable_auto_exposure") ~= "true" and core.is_singleplayer() then
        on_player_joins[#on_player_joins+1] = function(player)
            core.kick_player(player:get_player_name(), "Enable auto exposure to play this game!\n\nYou can also turn on the setting 1042>1042_auto_adjust_settings.")
        end
    end

    if core.settings:get("enable_post_processing") ~= "true" and core.is_singleplayer() then
        on_player_joins[#on_player_joins+1] = function(player)
            core.kick_player(player:get_player_name(), "Enable post processing to play this game!\n\nYou can also turn on the setting 1042>1042_auto_adjust_settings.")
        end
    end

    if core.settings:get("translucent_liquids") ~= "true" and core.is_singleplayer() then
        on_player_joins[#on_player_joins+1] = function(player)
            core.kick_player(player:get_player_name(), "Enable translucent liquids to play this game!\n\nYou can also turn on the setting 1042>1042_auto_adjust_settings.")
        end
    end

    if core.settings:get("enable_3d_clouds") ~= "true" and core.is_singleplayer() then
        on_player_joins[#on_player_joins+1] = function(player)
            core.kick_player(player:get_player_name(), "Enable 3d clouds to play this game!\n\nYou can also turn on the setting 1042>1042_auto_adjust_settings.")
        end
    end
end

if not core.is_singleplayer() and core.settings:get_bool("1042_warn_players_about_settings", true) then
    on_player_joins[#on_player_joins+1] = function(player)
        core.chat_send_player(player:get_player_name(), core.colorize("#eeee00", "It is recomended to load this game in single player to ensure proper rendering settings are on pior to using server mode. If the game does not look right or look dim/greyish, please try that."))
    end
end

if #on_player_joins > 0 then
    core.register_on_joinplayer(function(player)
        for _, func in ipairs(on_player_joins) do
            func(player)
        end
    end)
end

local path = core.get_modpath("1042_core")

dofile(path.."/game_storage.lua")
dofile(path.."/player_inv.lua")
dofile(path.."/player.lua")
dofile(path.."/funcs.lua")
dofile(path.."/privs.lua")
dofile(path.."/group_abms.lua")

