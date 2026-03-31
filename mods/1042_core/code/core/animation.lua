core_1042.animation = {}

core_1042.animation.registered_animations = {}

core_1042.animation.register_animation = function(entity_name, animation) -- name = entity:get_entity_name()
    if core_1042.animation.registered_animations[entity_name] == nil then
        core_1042.animation.registered_animations[entity_name] = {}
    end
    core_1042.animation.registered_animations[entity_name][animation.name] = animation
end

core_1042.animation.animate = function(_, __) end

core_1042.animation.animate = function(entity, animation)
    local entity_name
    if entity:is_player() then
        entity_name = "player"
    else
        entity_name = entity:get_entity_name()
    end

    local a = {}

    if animation ~= nil then
        if animation.name ~= nil and core_1042.animation.registered_animations[entity_name] then
            -- if: is formatted to ask for registerred anim
            -- and: the entity is registered as an animated entity
            local anim = core_1042.animation.registered_animations[entity_name][animation.name]
            anim.speed = animation.speed or anim.speed -- allow you to override the registered values
            anim.blend = animation.blend or anim.blend
            anim.loop = animation.loop or anim.loop
            a = anim
            --entity:set_animation(anim.range, anim.speed, anim.blend, anim.loop)
            if not anim.loop then
                core.after((anim.range.y - anim.range.x) / anim.speed, core_1042.animation.animate, entity, nil) -- reset after anim finished
            end
        else
            a = animation
            --entity:set_animation(animation.range, animation.speed, animation.blend, animation.loop)
        end
    else -- if no anim defined then reset the anim to default
        if core_1042.animation.registered_animations[entity_name] ~= nil and core_1042.animation.registered_animations[entity_name]["idle"] ~= nil then
            local anim = core_1042.animation.registered_animations[entity_name]["idle"] -- idle animations should be looped otherwise thread recursion will occur
            core.after(0, core_1042.animation.animate, entity, "idle")
            --entity:set_animation(anim.range, anim.speed, anim.blend, anim.loop)
        else
            a = {range={x=0,y=0}, speed=0, blend=nil, loop=false}
            --entity:set_animation({x=0,y=0}, 0, nil, false)
        end
    end

    if a.range ~= nil then
        entity:set_animation(a.range, a.speed, a.blend, a.loop)
    end
end