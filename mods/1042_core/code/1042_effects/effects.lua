
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

effects_api.effects["burning"] = {
    start_effect = function(player, mul)
        local overlay = player:hud_add({
            type = "image",
            position = {x=0, y=0},

            name = "1042_burning_overlay",

            scale = {x = 4, y = 4},

            alignment = {x=0, y=0},

            offset = {x=0, y=0},

            size = {x=0, y=0},

            z_index = -300,
        })
        local meta = player:get_meta()
        if meta:contains("burning_overlay") then
            player:hud_remove(meta:get_int("burning_overlay"))
        end
        meta:set_int("burning_overlay", overlay)
    end,
    end_effect = function(player)
        local meta = player:get_meta()
        if meta:contains("burning_overlay") then
            player:hud_remove(meta:get_int("burning_overlay"))
        end
    end,
}