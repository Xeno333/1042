testing_1042 = false

if not core.settings:get_bool("1042_enable_intigrated_tests", false) then 
    return

else
    testing_1042 = true
    local version = core.get_version()
    core.log("action", "Loading 1042_tests (" .. version.project .. " " .. version.string .. ")...")

end

tests_1042 = {}

function tests_1042.print(text)
    core.log("warning", "1042_tests: " .. tostring(text))
end



tests_1042.print("Registering tests to run on mods loaded...")

core.register_on_mods_loaded(
    function()
        local schem = schematics_1042.new_schematic()
        tests_1042.print("1042 schematic validation test: " .. tostring(schematics_1042.is_schamatic(schem)))

    end
)

tests_1042.print("1042_tests: Registered tests will run on mods loaded.")




core.log("action", "1042_tests loaded.")