core.log("action", "Loading 1042...")

local path = core.get_modpath("1042_core")
dofile(path.."/shared_lib.lua")
core.register_mapgen_script(path.."/shared_lib.lua")



local on_player_joins = {
    function(player)
        local name = player:get_player_name()
        local protocol_version = core.get_player_information(name).protocol_version
        if not protocol_version or protocol_version < 46 then
            core.disconnect_player(name, "You are on too old of a client, please update.")
        end
    end
}


if core.features.hotbar_hud_element ~= true then
    on_player_joins[#on_player_joins+1] = function(player)
        core.disconnect_player(player:get_player_name(), "You must update to luanti 5.10.0 or later to play this game.")
    end
end

if core.settings:get_bool("1042_enable_hardcore", false) then
    core.register_on_dieplayer(function(player, reason)
        local name = player:get_player_name()
        core.kick_player(name, "You died in 1042 while playing in hardcore mode.", false)
        core.ban_player(name)
    end)
end

-- key = {single_player, value}
local required_settings = {
    -- Required
    ["enable_shaders"] = {single_player=true, value="true", required=true},
    ["enable_post_processing"] = {single_player=true, value="true", required=true},
    ["translucent_liquids"] = {single_player=true, value="true", required=true},
    ["enable_clouds"] = {single_player=true, value="true", required=true},
    ["enable_3d_clouds"] = {single_player=true, value="true", required=true},
    ["enable_auto_exposure"] = {single_player=true, value="true", required=true},
    ["exposure_compensation"] = {single_player=true, value="0.5", required=true},

    -- Recommended
    ["enable_waving_water"] = {single_player=true, value="true"},
    ["smooth_lighting"] = {single_player=true, value="true"},
    ["enable_dynamic_shadows"] = {single_player=true, value="true"},
    ["enable_volumetric_lighting"] = {single_player=true, value="true"},
    ["enable_bloom"] = {single_player=true, value="true"},
    ["enable_water_reflections"] = {single_player=true, value="true"},
    ["soft_clouds"] = {single_player=true, value="true"},
    ["enable_fog"] = {single_player=true, value="true"},
}

if core.settings:get_bool("1042_auto_adjust_settings", false) then
    for name, value in pairs(required_settings) do
        core.settings:set(name, value.value)
    end

elseif not core.settings:get_bool("1042_ignore_required_settings", false) then
    for name, value in pairs(required_settings) do
        if value.required then
            if value.single_player then
                if core.is_singleplayer() and core.settings:get(name) ~= value.value then
                    on_player_joins[#on_player_joins+1] = function(player)
                        core.disconnect_player(player:get_player_name(), "Enable "..name.." to play this game!\n\nYou can also turn on the setting 1042>1042_auto_adjust_settings.")
                    end
                end

            elseif core.settings:get(name) ~= value.value then
                    error("Enable "..name.." to play this game!\n\nYou can also turn on the setting 1042>1042_auto_adjust_settings.")
            end
        end
    end
end

if not core.is_singleplayer() and core.settings:get_bool("1042_warn_players_about_settings", true) then
    on_player_joins[#on_player_joins+1] = function(player)
        core.chat_send_player(player:get_player_name(), core.colorize("#eeee00", "It is recommended to load this game in single player with the setting 1042>1042_auto_adjust_settings turned on, to ensure proper rendering settings are on pior to using server mode. If the game does not look right or look dim/greyish, please try that."))
    end
end




-- load mods

local path = core_1042.core_path .. "/code/"
local mod_load_order = {
    path .. "core/core.lua",

    path .. "1042_player/player.lua",
    path .. "1042_tests/init.lua",
    path .. "1042_achievements/init.lua",
    path .. "1042_nodes/init.lua",
    path .. "1042_tools/init.lua",
    path .. "1042_smithing/init.lua",
    path .. "1042_mobs/mobs.lua",
    path .. "1042_schematics/init.lua",
    path .. "1042_weather/init.lua",

    path .. "1042_mapgen/init.lua",
}


for _, init_file in ipairs(mod_load_order) do
    dofile(init_file)
end






local world_version = core_1042.get("1042_world_version")

if world_version == nil then
    core_1042.world_version = core_1042.version
    core_1042.set("1042_world_version", core_1042.world_version)
    core_1042.world_version_string = "1042 v" .. core_1042.world_version.major .. "." .. core_1042.world_version.minor .. "." .. core_1042.world_version.patch ..  core_1042.version_release_to_string[core_1042.world_version.release]

else
    core_1042.world_version = world_version
    core_1042.world_version_string = "1042 v" .. core_1042.world_version.major .. "." .. core_1042.world_version.minor .. "." .. core_1042.world_version.patch ..  core_1042.version_release_to_string[core_1042.world_version.release]

    if world_version.major < core_1042.oldest_supported_version.major or world_version.minor < core_1042.oldest_supported_version.minor
        or world_version.patch < core_1042.oldest_supported_version.patch or world_version.release > core_1042.oldest_supported_version.release then
            if core.is_singleplayer() then
                on_player_joins[#on_player_joins+1] = function(player)
                    core.disconnect_player(player:get_player_name(), "Wold is to old for " .. core_1042.version_string .. ", try an older version. World is on " .. core_1042.world_version_string)
                end
            else
                error("Wold is to old for " .. core_1042.version_string .. ", try an older version. World is on " .. core_1042.world_version_string)
            end
    end

end




if #on_player_joins > 0 then
    core.register_on_joinplayer(function(player)
        for _, func in ipairs(on_player_joins) do
            func(player)
        end
    end)
end


core.log("action", "1042 loaded.")