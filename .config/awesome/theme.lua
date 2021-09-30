---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gears = require("gears")

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}

theme.font          = "Iosevka Aile 9"

local xrdb          = xresources.get_current_theme()

theme.black         = xrdb["color0"]
theme.red           = xrdb["color1"]
theme.green         = xrdb["color2"]
theme.yellow        = xrdb["color3"]
theme.blue          = xrdb["color4"]
theme.magenta       = xrdb["color5"]
theme.cyan          = xrdb["color6"]
theme.white         = xrdb["color7"]

theme.gray          = xrdb["color8"]
theme.alt_red       = xrdb["color9"]
theme.turqoise      = xrdb["color10"]
theme.orange        = xrdb["color11"]
theme.alt_blue      = xrdb["color12"]
theme.purple        = xrdb["color13"]
theme.azur          = xrdb["color14"]
theme.offwhite      = xrdb["color15"]

theme.bg_normal     = xrdb["background"]
theme.bg_focus      = theme.gray
theme.bg_urgent     = theme.red
theme.bg_minimize   = theme.gray
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = xrdb["foreground"]
theme.fg_focus      = theme.white
theme.fg_urgent     = theme.white
theme.fg_minimize   = theme.white

theme.useless_gap   = dpi(5)
theme.border_width  = dpi(1)
theme.border_normal = "#000000"
theme.border_focus  = theme.gray
theme.border_marked = "#91231c"


-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

theme.wibar_height = dpi(27)

-- TAGLIST
theme.taglist_font = "Noto Sans 13"

theme.taglist_fg_focus      = theme.blue
theme.taglist_fg_urgent     = theme.blue
theme.taglist_fg_occupied   = theme.blue
theme.taglist_fg_empty      = theme.blue
theme.taglist_fg_volatile   = theme.blue

theme.taglist_bg_focus      = theme.yellow
theme.taglist_bg_urgent     = theme.red
theme.taglist_bg_occupied   = theme.white
theme.taglist_bg_empty      = theme.background
theme.taglist_bg_volatile   = theme.yellow

local tag_uline_size = dpi(3) 

theme.taglist_shape = gears.shape.rectangle
theme.taglist_squares_sel = gears.surface.load_from_shape(dpi(50),theme.wibar_height-tag_uline_size,gears.shape.rectangle,theme.bg_normal)
theme.taglist_squares_unsel = gears.surface.load_from_shape(dpi(50),theme.wibar_height-tag_uline_size,gears.shape.rectangle,theme.bg_normal)

--TASKLIST
theme.tasklist_fg_focus = theme.white
theme.tasklist_fg_urgent = theme.white
theme.tasklist_bg_focus = theme.purple
theme.tasklist_bg_urgent = theme.red

-- NOTIFICATIONS
-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = themes_path.."default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = themes_path.."default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path.."default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path.."default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path.."default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_path.."default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path.."default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path.."default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path.."default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_path.."default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path.."default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path.."default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path.."default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = themes_path.."default/titlebar/maximized_focus_active.png"

-- theme.wallpaper = themes_path.."default/background.png"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
theme.layout_max = themes_path.."default/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
theme.layout_tile = themes_path.."default/layouts/tilew.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

-- Generate Awesome icon:
--[[ theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
) ]]

-- theme.awesome_icon = "/usr/share/icons/Papirus/64x64/apps/distributor-logo-archlinux.svg"
-- theme.awesome_icon = gears.color.recolor_image("/usr/share/icons/ePapirus-Dark/symbolic/actions/view-list-bullet-symbolic.svg", theme.fg_focus)
-- theme.awesome_icon = gears.color.recolor_image("/usr/share/icons/ePapirus-Dark/symbolic/actions/view-app-grid-symbolic.svg", theme.fg_focus)
theme.awesome_icon = gears.color.recolor_image("/usr/share/icons/ePapirus-Dark/symbolic/actions/view-more-symbolic.svg", theme.fg_focus)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "/usr/share/icons/Papirus/"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
