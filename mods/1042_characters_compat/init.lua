-- characters_default/init.lua

characters.api.set_base_properties({
    mesh = "characters_default_player.glb",
    textures = {
        "character.png",
        --"characters_default_layer1.png"
    },
    visual_size = { x = 7, y = 7 },
    eye_height = 1.6,
})

characters.register_animation({
	name = "idle",
	range = {x = 65, y = 80}, 
	speed = 5,
	blend = 0.1,
	loop = true
})

characters.register_animation({
	name = "walk",
	range = {x = 0, y = 20},
	speed = 0, -- overridden by dynamic animaiton
	blend = 0.1,
	loop = true
})

characters.register_animation({
	name = "strafe",
	range = {x = 85, y = 95}, 
	speed = 0, -- overridden by dynamic animaiton
	blend = 0.1,
	loop = true
})

characters.register_animation({
	name = "fall",
	range = {x = 100, y = 120}, 
	speed = 15,
	blend = 0.5,
	loop = true,
    eye_offset = vector.new(0, -1, 0)
})

characters.register_animation({
	name = "swim",
	range = {x = 125, y = 145}, 
	speed = 10,
	blend = 2,
	loop = true,
    eye_offset = vector.new(0, -12, 0)
})

characters.register_animation({
	name = "swim_idle",
	range = {x = 150, y = 160}, 
	speed = 10,
	blend = 1,
	loop = true
})

characters.register_animation({
	name = "death",
	range = {x = 180, y = 200}, 
	speed = 30,
	blend = 0.1,
	loop = false
})

characters.register_animation({
	name = "lay",
	range = {x = 200, y = 200}, 
	speed = 0, -- overridden by dynamic animaiton
	blend = 0.5,
	loop = true,
    eye_offset = vector.new(0, -12, 0)
})

characters.register_animation({
	name = "crawl",
	range = {x = 205, y = 225}, 
	speed = 0, 
	blend = 0.1,
	loop = true,
    eye_offset = vector.new(0, -12, 0)
})

local calculate_eye_offset = function(player)
    local y_offset = 0
    local animation = characters.get_anim(player)
    if animation ~= nil and animation.eye_offset ~= nil and animation.eye_offset.y ~= nil and animation.eye_offset.y ~= 0 then
        y_offset = animation.eye_offset.y/10     -- TODO: a little broken, gonna have to make some visual diagnostics
    end
    return characters.api.model.eye_height+y_offset
end

characters.register_eye_offset_callback(function(player, animation)
    local y_offset = 0
    if animation.eye_offset ~= nil and animation.eye_offset.y ~= nil and animation.eye_offset.y ~= 0 then
        y_offset = animation.eye_offset.y/10     -- TODO: a little broken, gonna have to make some visual diagnostics
    end
    local y_base = characters.api.model.eye_height
    local cb = {-0.25, 0, -0.25, 0.25, y_base+y_offset+0.25, 0.25}
    characters.api.update_model(player, {collisionbox = cb})
end)

characters.api.moving = function(player)
    local cont = player:get_player_control()
    local deadstick = 0.01 -- needed for keyboard users as well because the movement controls are leaky apparently
    return {
        x=math.abs(cont.movement_x) > deadstick,
        y=math.abs(cont.movement_y) > deadstick,
    }
end

local submerged = function(player)
    local eyes = core.get_node(vector.offset(player:get_pos(), 0, calculate_eye_offset(player)-0.25, 0))
    return (core.registered_nodes[eyes.name].drawtype == "liquid" or core.registered_nodes[eyes.name].drawtype == "flowingliquid")
end

local wading = function(player)
    local feet = core.get_node(vector.offset(player:get_pos(), 0, 0, 0))
    return (core.registered_nodes[feet.name].drawtype == "liquid" or core.registered_nodes[feet.name].drawtype == "flowingliquid")
end

local crawlable = function(player)
    local eyes = core.get_node(vector.offset(player:get_pos(), 0, 1, 0))
    local feet = core.get_node(player:get_pos())
    return core.registered_nodes[eyes.name].walkable and not core.registered_nodes[feet.name].walkable
end

characters.is_on_ground = function(player)
    local stand = core.get_node(vector.offset(player:get_pos(), 0, -0.5, 0))
    return core.registered_nodes[stand.name].walkable
end

core.register_on_dieplayer(function(player, reason)
    --characters.animate_sequence(player, {name="death", next={name="lay"}})
    characters.animate(player, {name="death", next={name="lay"}})
    player:set_bone_override("Neck", {position = nil, rotation = nil})
end)

characters.api.add_step(function(player, dtime)
    if player:get_hp() <= 0 then return end

    local vel = player:get_velocity()
    local look = player:get_look_dir()
    local cont = player:get_player_control()
    local stand = core.get_node(player:get_pos())
    local eyes = core.get_node(vector.offset(player:get_pos(), 0, 1, 0))
    --local ph = player:get_physics_override()

    local speed = math.abs(vel.x) + math.abs(vel.z)

    if player:get_hp() > 0 then
        player:set_bone_override("Neck", { position = nil, rotation = {vec=vector.new((1-look.y+270)*1.6, 0, 0), interpolation=0.1}})
    end
    
    -- for movement, speed of animation should be affected by velocity
    if core.settings:get_bool("characters_allow_crawl", true) and crawlable(player) then
        characters.set_animation(player, {name="crawl"})
        if speed > 0.2 then
            if cont.movement_y > 0.001 then
                player:set_animation_frame_speed(25*speed)
            elseif cont.movement_y < 0.001 then
                player:set_animation_frame_speed(-25*speed)
            end
        else
            player:set_animation_frame_speed(0)
        end
    elseif submerged(player) then
        if characters.api.moving(player).y then
            -- swimming normally
            if speed > 0.2 then
                characters.set_animation(player, {name="swim"})
                player:set_animation_frame_speed(5*speed)
            else
                characters.set_animation(player, {name="swim_idle"})
            end
            --characters.set_animation(player, {name="swim"})
        elseif characters.api.moving(player).x then
            -- swimming on side
            if speed > 0.2 then
                characters.set_animation(player, {name="swim_idle"}) -- use swim idle for now till I get around to doing a swim strafe
                --player:set_animation_frame_speed(5*speed)
            else
                characters.set_animation(player, {name="swim_idle"})
            end
        else
            -- treading water
            characters.set_animation(player, {name="swim_idle"})
        end
    elseif vel.y < -20.1 then -- max flight speed is 20
        -- falling
        characters.set_animation(player, {name="fall"})
    elseif speed > 0.2 then
        if characters.is_on_ground(player) or wading(player) then
            if characters.api.moving(player).x and not characters.api.moving(player).y then
                -- sidestepping
                characters.set_animation(player, {name="strafe"})
                player:set_animation_frame_speed(13*speed)
            elseif characters.api.moving(player).y then
                -- walking
                characters.set_animation(player, {name="walk"})
                player:set_animation_frame_speed(9*speed)
            else
                characters.set_animation(player, {name="idle"})
            end
        else
            if characters.get_anim(player) ~= nil then
                local an = characters.get_anim(player).name
                if an == "walk" or an == "strafe" then
                    player:set_animation_frame_speed(1*speed)
                end
            else
                characters.set_animation(player, {name="idle"})
            end
        end
        -- no good way to check if player is using fast mode, sprinting will have to wait
    else
        -- idling
        characters.set_animation(player, {name="idle"})
    end
end, "1042")