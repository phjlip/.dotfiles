-------------------------------------------------------------------
------------------------------ Wibar ------------------------------
-------------------------------------------------------------------

local gears     = require("gears")
local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local naughty   = require("naughty")
local vicious   = require("vicious")
local dpi       = require('beautiful').xresources.apply_dpi
local widgets   = require("components.widgets")
local taglist   = require("components.taglist")
local tasklist  = require("components.tasklist")

-- Use another non-awesome statusbar
local hide_wibar = false

awful.screen.connect_for_each_screen(function(s)

    s.mytaglist = taglist.create(s)

    -- Create a tasklist widget
    s.mytasklist = tasklist.create(s)

    -- Add widgets to the wibox
    if hide_wibar == false then

        -- Create the wibox
        s.mywibox = awful.wibar({ position = "top", screen = s, shape = gears.shape.rounded_bar, border_width = 3})

        s.mywibox:setup {
            layout = wibox.layout.align.horizontal,
            { -- Left widgets
                layout = wibox.layout.fixed.horizontal,
                widgets.seperator,
                s.mytaglist,
                widgets.seperator,
                widgets.seperator,
            },
            -- Middle widget
            s.mytasklist, 
            { -- Right widgets
                layout = wibox.layout.fixed.horizontal,
                spacing = 10,
		        widgets.systray,
                widgets.keylayout,
		        widgets.openweather,
                widgets.volume,
		        widgets.net,
                widgets.cpu,
                widgets.memory,
		        widgets.thermal,
                widgets.battery,
                widgets.date,
                widgets.logout,
            },
        }

    else
        s.mywibox = awful.wibar({
            position = "top",
            screen = s,
            bg = "00",
            height = 27,
    })
    end
end)
