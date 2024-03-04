-- -------------------------------------------------------------------
-- rxyhn's aesthetic wezterm configuration
-- A GPU-accelerated cross-platform terminal emulator and multiplexer
--
-- https://github.com/rxyhn
-- -------------------------------------------------------------------

local wezterm = require("wezterm")

local function font_with_fallback(name, params)
    local names = { name, "Apple Color Emoji", "azuki_font" }
    return wezterm.font_with_fallback(names, params)
end

local colors = {
    -- special
    foreground = "#cdd6f4",
    darker_background = "#000a0e",
    background = "#111827",
    lighter_background = "#26323a",
    one_background = "#131e22",

        -- black
    color0  = '#1e1e2e',
    color8  = '#313244',

    -- red
    color1  = '#f38ba8',
    color9  = '#eba0ac',

    -- green
    color2  = '#a6e3a1',
    color10 = '#94e2d5',

    -- yellow
    color3  = '#f9e2af',
    color11 = '#fab387',

    -- blue
    color4  = '#89b4fa',
    color12 = '#b4befe',

    -- magent
    color5  = '#cba6f7',
    color13 = '#f5c2e7',

    -- cyan
    color6  = '#74c7ec',
    color14 = '#89dceb',

    -- white
    color7  = '#cdd6f4',
    color15 = '#cdd6f4',
}

return {
    -- OpenGL for GPU acceleration, Software for CPU
    front_end = "OpenGL",

    -- Font config
    -- font = font_with_fallback(font_name),
    -- font_rules = {
    --     {
    --         italic = true,
    --         font = font_with_fallback(font_name, { italic = true }),
    --     },
    --     {
    --         italic = true,
    --         intensity = "Bold",
    --         font = font_with_fallback(font_name, { bold = true, italic = true }),
    --     },
    --     {
    --         intensity = "Bold",
    --         font = font_with_fallback(font_name, { bold = true }),
    --     },
    --     {
    --         intensity = "Half",
    --         font = font_with_fallback(font_name, { weight = "Light" }),
    --     },
    -- },
    font = wezterm.font {
        family = 'JetBrainsMono Nerd Font',
        -- family = 'CodeNewRoman Nerd Font',
        weight = 'Medium',
    },
    font_size = 11,
    line_height = 1.0,

    -- Cursor style
    default_cursor_style = "BlinkingBlock",

    -- X11
    enable_wayland = false,

    -- Keybinds
    disable_default_key_bindings = false,
    keys = {
        {
            key = "|",
            mods = "CTRL|SHIFT",
            action = wezterm.action({
                SplitHorizontal = { domain = "CurrentPaneDomain" },
            }),
        },
        {
            key = "_",
            mods = "CTRL|SHIFT",
            action = wezterm.action({
                SplitVertical = { domain = "CurrentPaneDomain" },
            }),
        },
        {
            key = "w",
            mods = "CTRL|SHIFT",
            action = wezterm.action({ CloseCurrentPane = { confirm = false } }),
        },
        {
            key = "h",
            mods = "CTRL|SHIFT",
            action = wezterm.action({ ActivatePaneDirection = "Left" }),
        },
        {
            key = "l",
            mods = "CTRL|SHIFT",
            action = wezterm.action({ ActivatePaneDirection = "Right" }),
        },
        {
            key = "k",
            mods = "CTRL|SHIFT",
            action = wezterm.action({ ActivatePaneDirection = "Up" }),
        },
        {
            key = "j",
            mods = "CTRL|SHIFT",
            action = wezterm.action({ ActivatePaneDirection = "Down" }),
        },
        {
            key = "h",
            mods = "CTRL|SHIFT|ALT",
            action = wezterm.action({ AdjustPaneSize = { "Left", 1 } }),
        },
        {
            key = "l",
            mods = "CTRL|SHIFT|ALT",
            action = wezterm.action({ AdjustPaneSize = { "Right", 1 } }),
        },
        {
            key = "k",
            mods = "CTRL|SHIFT|ALT",
            action = wezterm.action({ AdjustPaneSize = { "Up", 1 } }),
        },
        {
            key = "j",
            mods = "CTRL|SHIFT|ALT",
            action = wezterm.action({ AdjustPaneSize = { "Down", 1 } }),
        },
        { -- browser-like bindings for tabbing
            key = "t",
            mods = "CTRL|SHIFT",
            action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }),
        },
        {
            key = "q",
            mods = "CTRL|SHIFT",
            action = wezterm.action({ CloseCurrentTab = { confirm = false } }),
        },
        {
            key = ">",
            mods = "CTRL|SHIFT",
            action = wezterm.action({ ActivateTabRelative = 1 }),
        },
        {
            key = "<",
            mods = "CTRL|SHIFT",
            action = wezterm.action({ ActivateTabRelative = -1 }),
        }, -- standard copy/paste bindings
        {
            key = "x",
            mods = "CTRL",
            action = "ActivateCopyMode",
        },
        {
            key = "v",
            mods = "CTRL|SHIFT",
            action = wezterm.action({ PasteFrom = "Clipboard" }),
        },
        {
            key = "c",
            mods = "CTRL|SHIFT",
            action = wezterm.action({ CopyTo = "ClipboardAndPrimarySelection" }),
        },
    },

    -- Aesthetic Night Colorscheme
    bold_brightens_ansi_colors = false,
    color_scheme = "Catppuccin",

    colors = {
        tab_bar = {
            active_tab = {
                bg_color = colors.darker_background,
                fg_color = colors.color4,
                italic = true,
            },
            inactive_tab = { bg_color = colors.background, fg_color = colors.foreground },
            inactive_tab_hover = { bg_color = colors.one_background, fg_color = colors.darker_background },
            new_tab = { bg_color = colors.lighter_background, fg_color = colors.darker_background },
            new_tab_hover = { bg_color = colors.color4, fg_color = colors.darker_background },
        },
    },

    window_frame = {
        -- font = wezterm.font { family = 'JetBrainsMono Nerd Font', weight = 'Medium' },
        active_titlebar_bg = colors.background,
    },

    -- Padding
    window_padding = {
        left = 5,
        right = 0,
        top = 10,
        bottom = 0,
    },

    -- Tab Bar
    enable_tab_bar = true,
    use_fancy_tab_bar = true,
    hide_tab_bar_if_only_one_tab = true,
    show_tab_index_in_tab_bar = true,
    tab_bar_at_bottom = true,

    -- General
    automatically_reload_config = true,
    inactive_pane_hsb = { saturation = 1.0, brightness = 1.0 },
    exit_behavior = "CloseOnCleanExit",
    window_decorations = "TITLE",
    selection_word_boundary = " \t\n{}[]()\"'`,;:",
}
