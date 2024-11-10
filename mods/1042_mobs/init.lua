

core.register_entity("1042_mobs:fish", {
    initial_properties = {
        visual = "mesh",
        mesh = "fish.gltf",
        textures = {"1042_plain_node.png^[colorize:#ff4400:128"},

        hp_max = 4,
        physical = true,

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
                dir.y = -9.8
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