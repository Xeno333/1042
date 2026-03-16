
effects_api.effects["tiredness"] = {
    start_effect = function(player, mul)
        player:set_lighting(
            {
                volumetric_light = {
                    strength = 0.1 / mul
                },
                shadows = {
                    intensity = 0.4 + (0.1 * mul),
                    tint = {r=0x99, g=0x99, b=0x99}
                },
                bloom = {
                    intensity = 0.1 + (0.02 * mul),
                    strength_factor = 1.0 + (0.1 * mul),
                    radius = 1.0
                },
                exposure = {
                    exposure_correction = 0.75 - 0.1 * mul
                }
            }
        )
    end,
    end_effect = function(player)
    end,
}