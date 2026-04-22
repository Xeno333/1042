
local rand = PcgRandom(math.random())


-- Fire ABMs

core.register_abm({
    label = "Fire Put Out",
    catch_up = true,
    interval = 4,
    chance = 4,
    nodenames = {"1042_core:fire"},
    neighbors = {"group:cools"},
    action = function(pos, node, active_object_count, active_object_count_wider)
        core.set_node(pos, {name = "air"})
    end
})

core.register_abm({
    label = "Fire Dies",
    catch_up = true,
    interval = 4,
    chance = 1,
    nodenames = {"1042_core:fire"},
    without_neighbors = {"group:burns"},
    action = function(pos, node, active_object_count, active_object_count_wider)
        core.set_node(pos, {name = "air"})
    end
})

core.register_abm({
    label = "Spread Fire",
    catch_up = true,
    interval = 16,
    chance = 2,
    nodenames = {"group:burns"},
    neighbors = {"group:burning"},

    action = function(pos, node, active_object_count, active_object_count_wider)
        if rand:next(1, core.get_item_group(node.name, "burns")) == 1 then 
            if (core.get_item_group(node.name, "wood") or 0) > 0 and rand:next(1, 4) == 1 then
                core.set_node(pos, {name = "1042_core:charcoal"})

            else
                core.set_node(pos, {name = "1042_core:fire"})

            end
        end
    end
})

local function geyser_squirt(pos)
    local len = rand:next(3, 20)
    core.add_particlespawner({
        amount = 50*len,
        time = len,
        size = 20,
        collisiondetection = true,
        texture = {name="1042_geyser_steam.png", blend="screen"},
        minpos = vector.offset(pos, -0.1, 0.5, -0.1),
        maxpos = vector.offset(pos, 0.1, 0.5, 0.1),
        minvel = {x=-1, y=20, z=-1},
        maxvel = {x=1, y=25, z=1},
        minacc = {x=0.1, y=-3, z=0.1},
        maxacc = {x=-0.1, y=-5, z=-0.1},
        minsize = 10,
        maxsize = 30,
        minexptime = 1,
        maxexptime = 3,
    })
    local handle = core.sound_play({name="1042_geyser", gain=2, pitch=1.1}, {loop=true, pos=pos, max_hear_distance = 128})
    core.after(len-1, core.sound_fade, handle, 1, 0)
end

core.register_abm({
    label = "Geyser Squirt",
    catch_up = false,
    interval = 10,
    chance = 10,
    nodenames = {"1042_core:geyser_nozzle"},
    action = function(pos, node, active_object_count, active_object_count_wider)
        local handle = core.sound_play({name="1042_geyser", gain=2, pitch=0.1}, {loop=false, pos=pos, max_hear_distance = 128})
        core.sound_fade(handle, 0.1, 0)
        core.after(5, geyser_squirt, pos)
    end
})

core.register_abm({
    label = "Gusher Bubble",
    catch_up = false,
    interval = 1,
    chance = 3,
    nodenames = {"1042_core:gusher_spout"},
    action = function(pos, node, active_object_count, active_object_count_wider)
        core.add_particlespawner({
            amount = 50,
            time = 1,
            size = 5,
            collisiondetection = true,
            collision_removal = true,
            texture = {name="1042_gusher_bubble.png", blend="screen"}, -- , blend = "add"
            minpos = vector.offset(pos, -0.2, 0.5, -0.2),
            maxpos = vector.offset(pos, 0.2, 0.5, 0.2),
            minvel = {x=-2, y=4, z=-2},
            maxvel = {x=2, y=8, z=2},
            minacc = {x=1, y=-20, z=1},
            maxacc = {x=-1, y=-30, z=-1},
            minsize = 4,
            maxsize = 6,
            minexptime = 1,
            maxexptime = 5,
        })
    end
})

--[[
    Notes:
        This competes with "Spread Fire"
        This adds the challenge of having to watch it to make sure it burns
]]
core.register_abm({
    label = "Light Charcoal",
    catch_up = true,
    interval = 8,
    chance = 4,
    nodenames = {"1042_core:charcoal"},
    neighbors = {"group:burning"},

    action = function(pos, node, active_object_count, active_object_count_wider)
        core.set_node(pos, {name = "1042_core:charcoal_burning"})
    end
})