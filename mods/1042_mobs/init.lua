core.log("action", "Loading 1042_mobs...")

core.register_entity("1042_mobs:fish", {
    initial_properties = {
        visual = "mesh",
        mesh = "fish.gltf",
        textures = {
            "1042_plain_node.png^[colorize:#ff4400:128",
            "1042_plain_node.png^[colorize:#ff4400:128",
            "1042_plain_node.png^[colorize:#ff4400:128"
        },

        hp_max = 4,
        physical = true,
        static_save = false,

        damage_texture_modifier = "",

        collisionbox = {
            -0.1, -0.1, -0.1,
            0.1, 0.2, 0.2
        },

        selectionbox = {
            -0.1, -0.1, -0.1,
            0.1, 0.2, 0.2, 
            rotate = true
        },
    },

    on_activate = function(self, staticdata, dtime_s)
        self.timer = 0
        self.rand = PseudoRandom(math.random(1, 5000))
        self.object:set_animation({x = 0, y = 40}, 4, 0, true)
    end,

    on_step = function(self, dtime, moveresult)
        self.timer = self.timer - dtime
        if self.timer <= 0 then
            self.timer = 2
            if core.get_item_group(core.get_node(self.object:get_pos() + vector.new(0, 1, 0)).name, "water") ~= 0 then
                local dir = vector.random_direction()
                dir.y = dir.y / 2
                self.object:set_velocity(dir)
                self.object:set_rotation(vector.new(-dir.y, math.pi/2 + math.atan2(dir.z, dir.x), 0)) -- Fish is offset by 3/4 pi for some reason, this needs fixed. #fixme

            elseif core.get_item_group(core.get_node(self.object:get_pos()).name, "water") ~= 0 then
                local dir = vector.random_direction()
                dir.y = -math.abs(dir.y)
                self.object:set_velocity(dir)
                self.object:set_rotation(vector.new(-dir.y, math.pi/2 + math.atan2(dir.z, dir.x), 0)) -- Fish is offset by 3/4 pi for some reason, this needs fixed. #fixme

            else
                local dir = vector.random_direction()
                dir.x = dir.x * 0.5
                dir.z = dir.z * 0.5
                dir.y = -4
                self.object:set_velocity(dir)
                self.object:set_rotation(vector.new(0.2, math.pi/2 + math.atan2(dir.z, dir.x), math.pi/2)) -- Fish is offset by 3/4 pi for some reason, this needs fixed. #fixme

                if self.rand:next(1, 4) == 1 then
                    self.object:set_hp(self.object:get_hp() - 1)
                end
            end
        end
    end,

    groups = {fleshy = 1}
})




core.register_entity("1042_mobs:pig", {
    initial_properties = {
        visual = "mesh",
        mesh = "pig.gltf",
        textures = {
            "1042_plain_node.png^[colorize:#664433:128", -- Foot
            "1042_plain_node.png^[colorize:#664433:128", -- Foot
            "1042_plain_node.png^[colorize:#664433:128", -- Foot
            "1042_plain_node.png^[colorize:#664433:128", -- Foot
            "1042_plain_node.png^[colorize:#774433:128", -- Body
            "1042_plain_node.png^[colorize:#664433:128", -- Head
            "1042_plain_node.png^[colorize:#994433:128", -- Nose
            "1042_plain_node.png^[colorize:#000000:128", -- Eye
            "1042_plain_node.png^[colorize:#000000:128"  -- Eye
        },
        static_save = false,

        hp_max = 10,
        physical = true,

        visual_size = {
            x = 3,
            y = 3
        },

        damage_texture_modifier = "",

        collisionbox = {
            -0.1, -0.5, -0.1,
            0.1, 0.5, 0.1
        },

        selectionbox = {
            -0.5, -0.5, -0.5,
            0.5, 0.5, 0.5, 
            rotate = true
        },

        stepheight = 1.1,
    },

    on_death = function(self, player)
        achievements_1042.achieve(player, "hog_slayer")

        local pos = self.object:get_pos()
        if core.get_node(pos).name == "air" then
            core.set_node(pos, {name = "1042_nodes:pork_raw"})
        else
            core.item_drop(ItemStack("1042_nodes:pork_raw"), self.object, pos)
        end
    end,

    on_activate = function(self, staticdata, dtime_s)
        self.timer = 0
        self.rand = PseudoRandom(math.random(1, 5000))
        self.object:set_animation({x = 0, y = 40}, 4, 0, true)
    end,

    on_step = function(self, dtime, moveresult)
        self.timer = self.timer - dtime
        if self.timer <= 0 then
            if self.rand:next(1, 5) == 1 then
                core.sound_play("pig", {gain = 1, pos = self.object:get_pos(), max_hear_distance = 32}, true)
            end

            self.timer = 4

            local dir = vector.random_direction()
            dir.y = -9.8
            dir.z = dir.z * 2
            dir.x = dir.x * 2
            self.object:set_velocity(dir)
            self.object:set_animation({x = 0, y = 40}, (math.abs(dir.x)+math.abs(dir.y))/2, 0, true)
            self.object:set_rotation(vector.new(0, 3*math.pi/2 + math.atan2(dir.z, dir.x), 0)) -- Offset by 1/4 pi for some reason, this needs fixed. #fixme

        else
            local dir = self.object:get_velocity()
            dir.y = -9.8
            self.object:set_velocity(dir)

        end
    end,

    on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir, damage)
        core.sound_play("pig", {gain = 1, pitch = 1.5, pos = self.object:get_pos(), max_hear_distance = 32}, true)

        self.timer = 4

        local dir = vector.random_direction()
        dir.y = -9.8
        dir.z = dir.z * 4
        dir.x = dir.x * 4
        self.object:set_velocity(dir)
        self.object:set_animation({x = 0, y = 40}, (math.abs(dir.x)+math.abs(dir.y))/2, 0, true)
        self.object:set_rotation(vector.new(0, 3*math.pi/2 + math.atan2(dir.z, dir.x), 0)) -- Offset by 1/4 pi for some reason, this needs fixed. #fixme

    end,

    groups = {fleshy = 1}
})

achievements_1042.register_achievement("hog_slayer", {
    achievement = core.colorize("#ff7755", "Hog Slayer!"),
    colour = "#ffccaa"
})


dofile(core.get_modpath("1042_mobs") .. "/mob_spawning.lua")

core.log("action", "1042_mobs loaded.")