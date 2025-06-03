core_1042.phases = {}

local callbacks = {
    complex_registration = {},
    startup = {},

    startup_done = {},
    tests = {}
}


function core_1042.phases.register_callback(phase, func)
    if callbacks[phase] then
        callbacks[phase][#callbacks[phase]+1] = func
        return true

    else
        return false
    end
end


core.register_on_mods_loaded(function()
    for _, func in pairs(callbacks.complex_registration) do
        func()
    end

    for _, func in pairs(callbacks.startup) do
        func()
    end
end)


core.after(0, function()
    for _, func in pairs(callbacks.startup_done) do
        func()
    end

    for _, func in pairs(callbacks.tests) do
        func()
    end
end)