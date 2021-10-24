-------------------------------------------------------------------
---------------------------- Taglist ------------------------------
-------------------------------------------------------------------

local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")

local taglist = {}

local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local symbols = { " ᚠ ", " ᛟ ", " ᛏ ", " ᛗ ", " ᚫ ", " ᛒ ", " ᛝ ", " ᛉ " }

taglist.create = function (screen)
		 awful.tag(symbols, screen, awful.layout.layouts[1])
                 return awful.widget.taglist {
                     screen  = screen,
                     filter  = awful.widget.taglist.filter.all,
                     buttons = taglist_buttons,
                     layout  = wibox.layout.fixed.horizontal,
                     style = {
                         spacing = 5,
                         shape = gears.shape.rectangle
                     }
                 }
                 end

return taglist
