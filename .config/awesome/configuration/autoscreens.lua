local awful = require("awful")
local filesystem = require("gears.filesystem")
local config_dir = filesystem.get_configuration_dir()

awful.screen.connect_signal("added", function(s)
	if awful.screen.count() > 1 then
		awful.spawn.with_shell("bash " .. config_dir .. "screenlayouts/docked.sh")
	end
end)

awful.screen.connect_signal("removed", function(s)
	if awful.screen.count() < 2 then
		awful.spawn.with_shell("bash " .. config_dir .. "screenlayouts/unplugged.sh")
	end
end)
