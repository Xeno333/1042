local function trunc(n, d)
    local m = 10^(d)
    return math.floor(n*m)/m
end
local function sign(n)
    return n/math.abs(n)
end

core.register_entity(":__builtin:item", {
    initial_properties = {
        hp_max = 1,
    
        collide_with_objects = true,
        physical = true,
        pointable = true,
    
        is_visible = false,
        glow = 1,
        infotext = "",
        static_save = true,
    
        visual = "wielditem",
        visual_size = {x = 0.3, y = 0.3},
    
        collisionbox = {
            -0.25, -0.25, -0.25,
            0.25, 0.25, 0.25
        },
        selectionbox = {
            -0.25, -0.25, -0.25,
            0.25, 0.25, 0.25,
            rotate = true
        }
    },


    get_staticdata = function(self)
        return core.serialize({
            itemstring = self.itemstring
        })
    end,
    on_activate = function(self, staticdata)
        if not staticdata or staticdata == "" then
            return
        end
    
        local data = core.deserialize(staticdata) or {}
    
        if not data.itemstring then
            self.object:remove()
            return
        end
    
        self.itemstring = data.itemstring
        self:set_item()
        self.guid = core_1042.rand:next()
    end,
    set_item = function(self, item)
        local stack = ItemStack(self.itemstring or item)
        self.guid = core_1042.rand:next()
        self.itemstring = stack:to_string()
        self.object:set_properties({
            is_visible = true,
            wield_item = stack,
            infotext = stack:get_short_description()
        })
    end,


    on_step = function(self)
        self.object:set_acceleration(vector.new(0,-9.5,0)) -- gravity
        local v = self.object:get_velocity()
        local pos = self.object:get_pos()

        -- slow
        local x = 0
        local z = 0
        if v.x ~= 0 then
            if (v.x > 0 and v.x <= 0.5) or (v.x < 0 and v.x >= -0.5) then
                x = 0
            else
                x = trunc(v.x, 2) - (sign(v.x) * 0.05)
            end
        end
        if v.z ~= 0 then
            if (v.z > 0 and v.z <= 0.5) or (v.z < 0 and v.z >= -0.5) then
                z = 0
            else
                z = trunc(v.z, 2) - (sign(v.z) * 0.05)
            end
        end
        self.object:set_velocity(vector.new(x, v.y, z))

        -- collect
		for object in core.objects_inside_radius(pos, 1) do
			local entity = object:get_luaentity()

			if entity and entity.name == "__builtin:item" and entity.guid ~= self.guid then
                local new = ItemStack(entity.itemstring)
                local res = new:add_item(ItemStack(self.itemstring))

                if res and res:get_count() > 0 then
                    entity.itemstring = new:to_string()
                    self.itemstring = res:to_string()

                else
                    entity.itemstring = new:to_string()
                    self.itemstring = nil
                    self.object:remove()
                    return
                end
			end
		end
    end,
    on_punch = function(self, puncher)
        if not self.itemstring then
            self.object:remove()
        end
    
        local stack = ItemStack(self.itemstring)
        local stack_left = stack:get_definition().on_pickup(stack, puncher, {type = "object", ref = self.object})
        if not stack then
            return
        end
    
        stack = ItemStack(stack_left)
        if stack:get_count() > 0 then
            self:set_item(stack)
    
        else
            self.itemstring = nil
            self.object:remove()
        end
    end,
    on_death = function(self)
        self.object:remove()
    end
})