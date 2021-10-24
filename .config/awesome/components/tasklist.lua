-------------------------------------------------------------------
---------------------------- Tasklist -----------------------------
-------------------------------------------------------------------

local gears     = require("gears")
local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")

local tasklist = {}

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

tasklist.create = function (screen)
                  return awful.widget.tasklist {
                      screen   = screen,
                      filter   = awful.widget.tasklist.filter.currenttags,
                      buttons  = tasklist_buttons,
                      layout   = {
                      	spacing_widget = {
                      		{
                      			forced_width  = 5,
                      			forced_height = 24,
                      			thickness     = 1,
                      			color         = beautiful.bg_normal,
                      			widget        = wibox.widget.separator
                      		},
                      		valign = 'center',
                      		halign = 'center',
                      		widget = wibox.container.place,
                      	},
                      	spacing = 10,
                      	layout  = wibox.layout.fixed.horizontal
                      },
                      -- Notice that there is *NO* wibox.wibox prefix, it is a template,
                      -- not a widget instance.
                      widget_template = {
                      	{
                      		wibox.widget.base.make_widget(),
                      		forced_height = 2,
                      		id            = 'background_role',
                      		widget        = wibox.container.background,
                      	},
                      	{
                      		{
                      			id     = 'clienticon',
                      			widget = awful.widget.clienticon,
                      		},
                      		margins = 2,
                      		widget  = wibox.container.margin
                      	},
                      	nil,
                      	create_callback = function(self, c, index, objects) --luacheck: no unused args
                      		self:get_children_by_id('clienticon')[1].client = c
                      	end,
                      	layout = wibox.layout.align.vertical,
                      },
                  }
                  end

return tasklist
