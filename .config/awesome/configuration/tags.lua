local awful = require("awful")

--- Tags
--- ~~~~

screen.connect_signal("request::desktop_decoration", function(s)
	--- Each screen has its own tag table.
	awful.tag({ " ᚠ ", " ᛟ ", " ᛏ ", " ᛗ ", " ᚫ ", " ᛒ ", " ᛝ ", " ᛉ " }, s, awful.layout.layouts[1])
end)
