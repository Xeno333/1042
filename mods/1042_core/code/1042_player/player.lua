core_1042.player = {}

core_1042.player.set_animation = function(player, anim)
    local meta = player:get_meta()
    if meta:get_string("animation") ~= anim.name then
        player:set_animation(anim.range, anim.speed, anim.blend or 0, anim.loop or true)
        meta:set_string("animation", anim.name)
    end
end

core_1042.player.get_animation = function(player)
    return player:get_meta():get_string("animation")
end

local path = core_1042.get_core_mod_path("1042_player")

dofile(path.."/player_api.lua")
dofile(path.."/player_setup.lua")
dofile(path.."/player_inv.lua")