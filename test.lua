testing_1042 = true

core = {
	log = function(level, text)
		if not level then level = "" end
		print(level .. "[testing]: " .. text)
	end
}

dofile("./mods/1042_schematics/init.lua")

