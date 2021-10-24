-------------------------------------------------------------------
----------------------------- Wigets ------------------------------
-------------------------------------------------------------------


local wibox       = require("wibox")
local awful       = require("awful")
local naughty     = require("naughty")
local vicious     = require("vicious")
vicious.contrib   = require("vicious.contrib")
local beautiful   = require("beautiful")
local dpi         = require('beautiful').xresources.apply_dpi


-- Adds underline to widget in a wrapped container
local widget_wrapper = function (wdg, color)
                       return wibox.widget { {
                                   wdg,
                                   bottom = beautiful.widget_uline_size,
                                   color = color,
                                   widget = wibox.container.margin
                               },
                               layout = wibox.container.margin 
		                }
                        end

local text_wrapper = function (string, color)
                     return "<span color=\""..color.."\">"..string.."</span>"
                     end

local widget = {}

-- Date
-------------------------------------------------------------------------------

local calendar_widget = require("widgets.calendar")
local cw = calendar_widget({
    theme = 'onehalf',
    placement = 'top_right',
})

date_widget = wibox.widget.textbox()
vicious.cache(vicious.widgets.date)
vicious.register(date_widget, vicious.widgets.date, text_wrapper(beautiful.icon_date, beautiful.uline_date).." %R %a, %d.%b.%y")
date_widget:connect_signal("button::press",
    function(_, _, _, button)
        if button == 1 then cw.toggle() end
    end)
widget.date = widget_wrapper(date_widget, beautiful.uline_date)

-- RAM
-------------------------------------------------------------------------------

memory_widget = wibox.widget.textbox()
vicious.cache(vicious.widgets.mem)
vicious.register(memory_widget, vicious.widgets.mem,
		function (widget, args)
		return ("%s %d%% (%.1fGB/%.1fGB)"):format(text_wrapper(beautiful.icon_memory, beautiful.uline_memory),
                                                 args[1],
                                                 args[2]/1000,
                                                 args[3]/1000)
		end)
widget.memory = widget_wrapper(memory_widget, beautiful.uline_memory)

-- Battery
-------------------------------------------------------------------------------

bat_widget = wibox.widget.textbox()
vicious.cache(vicious.widgets.bat)
vicious.register(bat_widget, vicious.widgets.bat,
                function (widget, args)
                    local label = { ["↯"] = beautiful.icon_bat_full,
                                    ["⌁"] = beautiful.icon_bat_unknown,
                                    ["+"] = { ["low"]   = beautiful.icon_bat_ac1, 
                                          ["low-mid"]   = beautiful.icon_bat_ac2,
                                          ["mid"]       = beautiful.icon_bat_ac3,
                                          ["mid-high"]  = beautiful.icon_bat_ac4,
                                          ["high"]      = beautiful.icon_bat_ac5 },
                                    ["-"] = { ["low"]   = beautiful.icon_bat_dc1,
                                          ["low-mid"]   = beautiful.icon_bat_dc2,
                                          ["mid"]       = beautiful.icon_bat_dc3, 
                                          ["mid-high"]  = beautiful.icon_bat_dc4,
                                          ["high"]      = beautiful.icon_bat_dc5 }}
                    local sym = ""
                    if args[1] == "+" or args[1] == "-" then
                        if args[2] <= 20 then sym = label[args[1]]["low"]
                        elseif args[2] <= 40 then sym = label[args[1]]["low-mid"]
                        elseif args[2] <= 60 then sym = label[args[1]]["mid"]
                        elseif args[2] <= 80 then sym = label[args[1]]["mid-high"]
                        else sym = label[args[1]]["high"]
                        end
                    else
                        sym = label[args[1]]
                end
		return ("%s %d%%"):format(text_wrapper(sym, beautiful.icon_bat_color[sym]), args[2])
		end, 61, "BAT0")
bat_widget:buttons(awful.util.table.join(awful.button(
    {}, 1,
    function ()
	naughty.destroy(notification)
        notification = naughty.notify{
            title = "Battery indicator",
            text = vicious.call(
                vicious.widgets.bat,
		"Remaining time: $3\nWear level: $4\nPresent rate: $5", "0") }
    end)))
widget.battery = widget_wrapper(bat_widget, beautiful.uline_bat)

-- CPU
-------------------------------------------------------------------------------

cpu_widget = wibox.widget.textbox()
vicious.cache(vicious.widgets.cpu)
vicious.register(cpu_widget, vicious.widgets.cpu, text_wrapper(beautiful.icon_cpu, beautiful.uline_cpu).." $1%", 3)
widget.cpu = widget_wrapper(cpu_widget, beautiful.uline_cpu)

-- Volume
-------------------------------------------------------------------------------

local pulse = require("widgets.pulse")
volume_widget = wibox.widget.textbox()
local sink = "@DEFAULT_SINK@"
vicious.cache(pulse)
vicious.register(volume_widget, pulse,
                    function (widget, args)
                        local sym = ""
                        local vol = tonumber(args[1])
                        if vol < 1 then sym = beautiful.icon_volume0
                        elseif vol <= 25 then sym = beautiful.icon_volume1
                        elseif vol <= 75 then sym = beautiful.icon_volume2
                        else sym = beautiful.icon_volume3
                        end
                    return text_wrapper(sym, beautiful.uline_volume).." "..vol.."%"
                    end, 3601, sink)
volume_widget:buttons(awful.util.table.join(
    awful.button({}, 1, function () pulse.toggle(sink) vicious.force({volume_widget}) end),
    awful.button({}, 3, function () awful.util.spawn("pavucontrol") end),
    awful.button({}, 4, function () pulse.add(3, sink) vicious.force({volume_widget}) end),
    awful.button({}, 5, function () pulse.add(-3, sink) vicious.force({volume_widget}) end)))
widget.volume = widget_wrapper(volume_widget, beautiful.uline_volume)

-- Network
-------------------------------------------------------------------------------

local interface = ""
local get_interface = function ()
    awful.spawn.easy_async_with_shell("ip link show | awk '/state UP/ {print $2}'",
        function(stdout, stderr, reason, exit_code)
            interface = string.match(stdout, "%w+")
        end)
end

net_widget = wibox.widget.textbox()
vicious.cache(vicious.widgets.net)
vicious.register(net_widget, vicious.widgets.net,
                    function (widget, args)
                        get_interface()
                    return ("%s %s: %skb %skb"):format(text_wrapper(beautiful.icon_net, beautiful.uline_net),
                                                        interface,
                                                        args["{"..interface.." down_kb}"],
                                                        args["{"..interface.." up_kb}"])
                    end, 2)
widget.net = widget_wrapper(net_widget, beautiful.uline_net)

-- Wifi
-------------------------------------------------------------------------------

--[[ wifi_widget = wibox.widget.textbox()
vicious.cache(vicious.widgets.wifi)
vicious.register(wifi_widget, vicious.widgets.wifi, "", 2)
widget.wifi = widget_wrapper(wifi_widget, beautiful.uline_wifi) ]]

-- Thermal
-------------------------------------------------------------------------------

thermal_widget = wibox.widget.textbox()
vicious.cache(vicious.widgets.thermal)
vicious.register(thermal_widget, vicious.widgets.thermal, text_wrapper(beautiful.icon_thermal, beautiful.uline_thermal).." $1°C", 5, "thermal_zone0")
widget.thermal = widget_wrapper(thermal_widget, beautiful.uline_thermal)

-- Airport Weather Station
-------------------------------------------------------------------------------

--[[ weather_widget = wibox.widget.textbox()
vicious.cache(vicious.widgets.weather)
vicious.register(weather_widget, vicious.widgets.weather, "WEATHER: ${city} ${weather} ${tempc}^C", 97, "EDDB")
widget.weather = widget_wrapper(weather_widget, beautiful.uline_weather) ]]

-- Airport Weather Station
-------------------------------------------------------------------------------

local f = io.popen("cat ~/.config/owmkey")
local app_id = string.match(f:read("*all"),"%w+")
f:close()
openweather_widget = wibox.widget.textbox()
vicious.cache(vicious.contrib.openweather)
vicious.register(openweather_widget, vicious.contrib.openweather,
                function (widget, args)
                    local symbols = { ["Thunderstorm"] = beautiful.icon_weather_thunder,
                                      ["Drizzle"]      = beautiful.icon_weather_drizzle,
                                      ["Rain"]         = beautiful.icon_weather_rain,
                                      ["Snow"]         = beautiful.icon_weather_snow,
                                      ["Mist"]         = beautiful.icon_weather_atmo,
                                      ["Fog"]          = beautiful.icon_weather_atmo,
                                      ["Clear"]        = beautiful.icon_weather_clear,
                                      ["Clouds"]       = beautiful.icon_weather_clouds, }
                    if string.match(args["{weather}"], "freezing") then symbols["Rain"] = beautiful.icon_weather_rain_snow
                    elseif string.match(args["{weather}"], "rain") then
                        symbols["Drizzle"] = beautiful.icon_weather_rain 
                        symbols["Snow"] = beautiful.icon_weather_rain_snow
                    elseif string.match(args["{weather}"], "few") then symbols["Clouds"] = beautiful.icon_weather_clouds_few
                    elseif string.match(args["{weather}"], "scattered") then symbols["Clouds"] = beautiful.icon_weather_clouds_scattered
                    elseif string.match(args["{weather}"], "broken") then symbols["Clouds"] = beautiful.icon_weather_clouds_broken
                    elseif string.match(args["{weather}"], "overcast") then symbols["Clouds"] = beautiful.icon_weather_clouds_overcast
                    elseif string.match(args["{weather}"], "sleet") then symbols["Snow"] = beautiful.icon_weather_rain_snow
                    elseif string.match(args["{weather}"], "shower") then
                        symbols["Snow"] = beautiful.icon_weather_rain_snow
                        symbols["Rain"] = beautiful.icon_weather_rain_heavy
                    end
                return ("%s %s°C %s"):format(text_wrapper(symbols[args["{sky}"]], beautiful.uline_weather),args["{temp c}"],args["{city}"])
                end, 3, {city_id = "2950159", app_id = app_id})
widget.openweather = widget_wrapper(openweather_widget, beautiful.uline_weather)

-- Keyboard Layout
-------------------------------------------------------------------------------

keylayout_widget = awful.widget.keyboardlayout()
widget.keylayout = widget_wrapper(keylayout_widget, beautiful.uline_key)

-- Logout
-------------------------------------------------------------------------------

logout_widget = require("widgets.logout")
widget.logout = logout_widget()

-- Systray
-------------------------------------------------------------------------------

widget.systray = wibox.widget.systray()

-- Seperator
-------------------------------------------------------------------------------

widget.seperator = wibox.widget{ markup = "   ", widget = wibox.widget.textbox, }


return widget
