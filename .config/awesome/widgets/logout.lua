-------------------------------------------------
-- Logout Menu Widget for Awesome Window Manager
-- More details could be found here:
-- https://github.com/streetturtle/awesome-wm-widgets/tree/master/logout-menu-widget

-- @author Pavel Makhov
-- @copyright 2020 Pavel Makhov
-------------------------------------------------

local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local HOME = os.getenv('HOME')
local ICON_DIR = '/usr/share/icons/Papirus/symbolic/actions/'

local logout_menu_widget = wibox.widget {
    {
        markup = "<span color=\""..beautiful.red.."\" font=\""..beautiful.widget_icon_size.."\"> </span>",
        widget = wibox.widget.textbox,
    },
    margins = 4,
    layout = wibox.container.margin
}

local popup = awful.popup {
    ontop = true,
    visible = false,
    shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 4)
    end,
    border_width = 1,
    border_color = beautiful.bg_focus,
    maximum_width = 400,
    offset = { y = 5 },
    widget = {}
}
local rows = { layout = wibox.layout.fixed.vertical }

-- TODO very ugly with 'already ran' method
local ran = false

local function worker(user_args)

    if ran == true then
        return logout_menu_widget
    end

    local args = user_args or {}

    local font = args.font or beautiful.font

    -- hibernate: saves state of computer to hard disk and powers off. resumes with saved state.
    -- suspend: puts computer to low power consumption mode. if computer dies, state is lost.
    local onlogout = args.onlogout or function () awesome.quit() end
    local onlock = args.onlock or function() awful.spawn.with_shell("xscreensaver-command -lock") end
    local onsuspend = args.onsuspend or function() awful.spawn.with_shell("systemctl suspend") end
    local onreboot = args.onreboot or function() awful.spawn.with_shell("systemctl reboot") end
    local onpoweroff = args.onpoweroff or function() awful.spawn.with_shell("systemctl poweroff") end

    local menu_items = {
        { name = 'Log out', icon_name = 'system-log-out-symbolic.svg', command = onlogout },
        { name = 'Lock', icon_name = 'system-lock-screen-symbolic.svg', command = onlock },
        { name = 'Suspend', icon_name = 'system-suspend-symbolic.svg', command = onsuspend },
        { name = 'Reboot', icon_name = 'system-restart-symbolic.svg', command = onreboot },
        { name = 'Power off', icon_name = 'system-shutdown-symbolic.svg', command = onpoweroff },
    }

    local count = 0
    for _, item in ipairs(menu_items) do

        count = count + 1

        local row = wibox.widget {
            {
                {
                    {
                        image = ICON_DIR .. item.icon_name,
                        resize = false,
                        widget = wibox.widget.imagebox
                    },
                    {
                        text = item.name,
                        font = font,
                        widget = wibox.widget.textbox
                    },
                    spacing = 12,
                    layout = wibox.layout.fixed.horizontal
                },
                margins = 8,
                layout = wibox.container.margin
            },
            bg = beautiful.bg_normal,
            widget = wibox.container.background
        }

        row:connect_signal("mouse::enter", function(c) c:set_bg(beautiful.bg_focus) end)
        row:connect_signal("mouse::leave", function(c) c:set_bg(beautiful.bg_normal) end)

        local old_cursor, old_wibox
        row:connect_signal("mouse::enter", function()
            local wb = mouse.current_wibox
            old_cursor, old_wibox = wb.cursor, wb
            wb.cursor = "hand1"
        end)
        row:connect_signal("mouse::leave", function()
            if old_wibox then
                old_wibox.cursor = old_cursor
                old_wibox = nil
            end
        end)

        row:buttons(awful.util.table.join(awful.button({}, 1, function()
            popup.visible = not popup.visible
            item.command()
        end)))

        table.insert(rows, row)
    end
    popup:setup(rows)

    logout_menu_widget:buttons(
            awful.util.table.join(
                    awful.button({}, 1, function()
                        if popup.visible then
                            popup.visible = not popup.visible
                        else
                            popup:move_next_to(mouse.current_widget_geometry)
                        end
                    end)
            )
    )
    
    ran = true
    return logout_menu_widget
end

return setmetatable(logout_menu_widget, { __call = function(_, ...) return worker(...) end })
