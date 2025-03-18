-- Core

testing_1042 = false -- Flag to use to enable WIP features or tests

tests_1042 = {
    registered_tests = {},

    print = function(text)
        if testing_1042 then
            core.log("warning", "1042_tests: " .. tostring(text))

            return true
        end

        return false
    end,

    register_test = function(namein, func, run_on_loaded)
        local name = tostring(namein)

        if namein and func and testing_1042 and not tests_1042.registered_tests[name] then
            if run_on_loaded ~= true then
                tests_1042.registered_tests[name] = {func = func, run_on_loaded = false}
                tests_1042.print("Registered new test: '" .. name .. "'.")
                return true
            end          
            
            tests_1042.registered_tests[name] = {func = func, run_on_loaded = true}
            tests_1042.print("Registered new test: '" .. name .. "' to run on mods loaded.")
            return true
        end

        return false
    end
}

-- Run test
core.register_chatcommand("run_test", {
    description = "Run test.",
    params = "<test>",
    privs = {["debug"] = true},

    func = function(name, testname)
        local test = tests_1042.registered_tests[testname]
        if test then
            local ret = "Result of test '" .. testname .. "': " .. tostring(test.func(name) or "NO RETURN")
            tests_1042.print(ret)
            return true, ret
        end

        return false, "No such test!"
    end
})





-- Secondary

-- Check if enabled
if not core.settings:get_bool("1042_enable_intigrated_tests", false) then 
    return
end



-- Enable
testing_1042 = true -- Flag to use to enable WIP features or tests

local version = core.get_version()
core.log("action", "Loading 1042_tests (" .. version.project .. " " .. version.string .. ")...")








core_1042.phases.register_callback("tests", function()
    for name, test in pairs(tests_1042.registered_tests) do
        if test.run_on_loaded then
            tests_1042.print("Result of test '" .. name .. "': " .. tostring(test.func() or "NO RETURN"))
        end
    end
end)


core.log("action", "1042_tests loaded.")