effects_api = {}

effects_api.cache = {}

effects_api.effects = {}


function effects_api.effect(enable, effect, player, mul, time)
    if not effects_api.effects[effect] then
        return nil
    end

    if enable and mul ~= 0 then
        effects_api.effects[effect].start_effect(player, mul)
        if time then
            core.after(time, function()
                effects_api.effects[effect].end_effect(player)
            end)
        end
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

        if not effects_api.effects[effect] or not mul then
            return true, "Failed!"
        end

        effects_api.effect(true, effect, core.get_player_by_name(name), mul, nil)

        return true, "Done!"
    end
})
