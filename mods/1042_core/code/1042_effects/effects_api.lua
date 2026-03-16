effects_api = {}

effects_api.cache = {}

effects_api.effects = {}


function effects_api.effect(enable, effect, player, mul)
    if not effects_api.effects[effect] then
        return nil
    end

    if enable then
        effects_api.effects[effect].start_effect(player, mul)
        return true
    else
        effects_api.effects[effect].end_effect(player)
        return false
    end

end



core.register_chatcommand("effect", {
    description = "Effect",
    func = function(name, param)

        local params = {}
        for s in string.gmatch(param, "([^,%s+]+)") do
            params[#params+1] = s
        end

        local effect = params[1]
        local mul = tonumber(params[2])

        if not effects_api.effects[effect] then
            return true, "Failed!"
        end

        effects_api.effects[effect].start_effect(core.get_player_by_name(name), mul)

        return true, "Done!"
    end
})
