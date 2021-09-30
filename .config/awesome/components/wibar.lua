-------------------------------------------------------------------
------------------------------ Wibar ------------------------------
-------------------------------------------------------------------

local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
local dpi = require('beautiful').xresources.apply_dpi

local hide_wibar = false

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- Widgets
local battery_widget = require("widgets.battery")
local logout_widget = require("widgets.logout")
local cpu_widget = require("widgets.cpu")
local ram_widget = require("widgets.ram")
local volume_widget = require("widgets.volume")
local calendar_widget = require("widgets.calendar")
local sep_widget = wibox.widget{
        markup = "  ",
        widget = wibox.widget.textbox,
}

-- Create a textclock widget
mytextclock = wibox.widget.textclock()

local cw = calendar_widget({
    theme = 'onehalf',
    placement = 'top_right',
})

mytextclock:connect_signal("button::press",

function(_, _, _, button)
    if button == 1 then cw.toggle() end
end)

-- Systray Widget
local mysystray = wibox.widget.systray()

-- Create a wibox for each screen and add it
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

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))


awful.screen.connect_for_each_screen(function(s)

    awful.tag({ " ᚠ ", " ᛟ ", " ᛏ ", " ᛗ ", " ᚫ ", " ᛒ ", " ᛝ ", " ᛉ " }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        layout  = wibox.layout.fixed.horizontal,
        style = {
            spacing = 5,
            shape = gears.shape.rectangle
        }
        --[[ widget_template = {
            {
                {
                    {
                        id     = 'text_role',
                        widget = wibox.widget.textbox,
                    },
                    left = 10,
                    right = 10,
                    widget = wibox.container.margin,
                },
                layout = wibox.layout.fixed.horizontal,
            },
            left  = 3,
            right = 3,
            widget = wibox.container.margin
        }, ]]
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        style    = {
            shape_border_width = 1,
            shape_border_color = '#050505',
            shape  = gears.shape.rounded_bar,
        },
        layout   = {
            spacing = 10,
            spacing_widget = {
                {
                    forced_width = 5,
                    shape        = gears.shape.circle,
                    widget       = wibox.widget.separator
                },
                valign = 'center',
                halign = 'center',
                widget = wibox.container.place,
            },
            layout  = wibox.layout.fixed.horizontal
        },
        -- Notice that there is *NO* wibox.wibox prefix, it is a template,
        -- not a widget instance.
        widget_template = {
            {
                {
                    {
                        {
                            id     = 'icon_role',
                            widget = wibox.widget.imagebox,
                        },
                        margins = 2,
                        widget  = wibox.container.margin,
                    },
                    {
                        id     = 'text_role',
                        widget = wibox.widget.textbox,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left  = 10,
                right = 10,
                widget = wibox.container.margin
            },
            id     = 'background_role',
            widget = wibox.container.background,
        },
    }

    -- Add widgets to the wibox
    if hide_wibar == false then

        -- Create the wibox
        s.mywibox = awful.wibar({ position = "top", screen = s, shape = gears.shape.rounded_bar, border_width = 3})

        s.mywibox:setup {
            layout = wibox.layout.align.horizontal,
            { -- Left widgets
                layout = wibox.layout.fixed.horizontal,
                sep_widget,
                -- mylauncher,
                s.mytaglist,
                s.mypromptbox,
            },
            s.mytasklist, -- Middle widget
            { -- Right widgets
                layout = wibox.layout.fixed.horizontal,
                mykeyboardlayout,
                mysystray,
                volume_widget{
                    widget_type = 'horizontal_bar'
                },
                cpu_widget(),
                ram_widget(),
                battery_widget(),
                mytextclock,
                logout_widget(),
                sep_widget,
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
