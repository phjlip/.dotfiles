-------------------------------------------------------------------
--------------------------- Titlebar ------------------------------
-------------------------------------------------------------------


local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- turn titlebar on when client is floating
-------------------------------------------------------------------------------
client.connect_signal("property::floating", function(c)
    if c.floating and not (c.requests_no_titlebar or c.fullscreen or c.type == "dock") then
        awful.titlebar.show(c)
    else
        awful.titlebar.hide(c)
    end
end)

-- turn tilebars on when layout is floating
-------------------------------------------------------------------------------
awful.tag.attached_connect_signal(nil, "property::layout", function (t)
    local float = t.layout.name == "floating"
    for _,c in pairs(t:clients()) do
        c.floating = float
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
-------------------------------------------------------------------------------
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    -- awful.titlebar(c, {size = 100}) : setup {
    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            -- awful.titlebar.widget.floatingbutton (c),
            {
            	awful.titlebar.widget.stickybutton   (c),
		margins = dpi(4),
		widget = wibox.container.margin
	    },
            {
            	awful.titlebar.widget.ontopbutton    (c),
		margins = dpi(4),
		widget = wibox.container.margin
	    },
            {
            	awful.titlebar.widget.minimizebutton (c),
		margins = dpi(4),
		widget = wibox.container.margin
	    },
            {
            	awful.titlebar.widget.maximizedbutton(c),
		margins = dpi(4),
		widget = wibox.container.margin
	    },
	    {
            	awful.titlebar.widget.closebutton    (c),
		margins = dpi(4),
		widget = wibox.container.margin
	    },
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

