
core.register_entity("1042_core:thrown_thing", {
    initial_properties = {
        visual = "mesh",
        mesh = "nugget.obj",
        textures = {"1042_stone.png"},

        hp_max = 1,
        physical = true,
        static_save = false,

        damage_texture_modifier = "",

        selection_box = {
            type = "fixed",
            fixed = {-0.1, -0.5, -0.1, 0.1, -0.3, 0.1}
        },
        collision_box = {
            type = "fixed",
            fixed = {-0.1, -0.5, -0.1, 0.1, -0.3, 0.1}
        },
    },

    visual_size = {
        x = 10,
        y = 10
    },

    on_activate = function(self, staticdata, dtime_s)
        self.object:set_acceleration(vector.new(0, -3, 0))
    end,

    on_death = function(self, player)
        local pos = self.object:get_pos()
        if core.get_node(pos).name == "air" then
            core.set_node(pos, {name = "1042_core:throwing_thing"})
        else
            core.item_drop(ItemStack("1042_core:throwing_thing"), self.object, pos)
        end
    end,

    on_step = function(self, dtime, moveresult)
        if moveresult.collides then
            self.object:set_velocity(vector.zero())

            if moveresult.collisions[1].type == "object" then
                moveresult.collisions[1].object:set_hp(moveresult.collisions[1].object:get_hp() - 5)

                core.item_drop(ItemStack("1042_core:throwing_thing"), self.object, moveresult.collisions[1].new_pos)
                self.object:remove()
                return
            end
        end

        if self.object:get_velocity() == vector.zero() then
            local pos = self.object:get_pos()
            if core.get_node(pos).name == "air" then
                core.set_node(pos, {name = "1042_core:throwing_thing"})
            else
                core.item_drop(ItemStack("1042_core:throwing_thing"), self.object, pos)
            end

            self.object:remove()
        end
    end,

    groups = {projectile = 1}
})





core_1042.registry.register_material("1042_core:throwing_thing", {
    description = core_1042.lorelang.translate("Throwing Thing"),
    drawtype = "mesh",
    mesh = "nugget.obj",
    tiles = {"1042_stone.png"},
    use_texture_alpha = "opaque",

    paramtype = "light",
    sunlight_propagates = true,
    walkable = true,
    buildable_to = false,

    selection_box = {
        type = "fixed",
        fixed = {-0.1, -0.5, -0.1, 0.1, -0.3, 0.1}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.1, -0.5, -0.1, 0.1, -0.3, 0.1}
    },

    sounds = {
        dig = {
            name = "stone_dig",
            gain = 0.3,
            pitch = 0.5
        },
        place = {
            name = "stone_walk",
            gain = 1,
            pitch = 0.5
        }
    },

    on_use = function(itemstack, player, pointed_thing)
        local pos = player:get_pos()
        pos.y = pos.y + player:get_properties().eye_height
        local dir = player:get_look_dir()

        local obj = core.add_entity(pos, "1042_core:thrown_thing")
        if obj then
            local m = 5
            obj:set_velocity(vector.multiply(dir, vector.new(m, m, m)))
        end

        print(player:get_player_name() .. " threw a thing")
    end,
    
    groups = {dig_immediate = 1, rock = 1, falling_node = 1},

    item_type = "node",
}, 1, nil, nil)