-- chat_commands.lua

core.register_chatcommand("killme", {
    description = "Kill slef instantly.",
    func = function(name)
        core.get_player_by_name(name):set_hp(0)
        return true
    end
})
