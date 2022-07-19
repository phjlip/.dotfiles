local awful = require("awful")

if awful.screen:count() > 1 then
	awful.spawn("firefox", { tag = awful.screen.primary.tags[1] })
	awful.spawn("kitty", { tag = awful.screen.primary.tags[1] })
	awful.spawn("emacs", { tag = awful.screen[awful.screen.primary.index-1].tags[1] })
	awful.spawn("thunderbird", { tag = awful.screen[awful.screen.primary.index-1].tags[2] })
else
	awful.spawn("firefox", { tag = awful.screen.primary.tags[1] })
	awful.spawn("kitty", { tag = awful.screen.primary.tags[1] })
	awful.spawn("emacs", { tag = awful.screen.primary.tags[3] })
	awful.spawn("thunderbird", { tag = awful.screen.primary.tags[4] })
end
