

core.register_entity("1042_mobs:fish", {
    initial_properties = {
        visual = "mesh",
        mesh = "fish.gltf",
        textures = {"1042_plain_node.png^[colorize:#ff4400:128"},
        hp_max = 10,
    },

    on_activate = function(self, staticdata, dtime_s)
        self.object:set_animation({x = 0, y = 40}, 4, 0, true)
    end,

    groups = {fleshy = 1}
})