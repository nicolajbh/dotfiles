-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

local function move_pane(key, direction)
    return {
        key = key,
        mods = "LEADER",
        action = wezterm.action.ActivatePaneDirection(direction),
    }
end

local function resize_pane(key, direction)
    return {
        key = key,
        action = wezterm.action.AdjustPaneSize({ direction, 3 }),
    }
end

-- This is where you actually apply your config choices

config.color_scheme = "Kanagawa (Gogh)"

config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 19

-- tab bars
config.enable_tab_bar = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_max_width = 32

-- key configs
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
-- split pane
config.keys = {
    {
        key = "s",
        mods = "LEADER",
        action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    {
        key = "v",
        mods = "LEADER",
        action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    {
        key = "a",
        -- When we're in leader mode _and_ CTRL + A is pressed...
        mods = "LEADER|CTRL",
        -- Actually send CTRL + A key to the terminal
        action = wezterm.action.SendKey({ key = "a", mods = "CTRL" }),
    },
    move_pane("j", "Down"),
    move_pane("k", "Up"),
    move_pane("l", "Right"),
    move_pane("h", "Left"),
    {
        key = "w",
        mods = "LEADER",
        action = wezterm.action.CloseCurrentPane({ confirm = true }),
    },
    {
        -- When we push LEADER + R...
        key = "r",
        mods = "LEADER",
        -- Activate the `resize_panes` keytable
        action = wezterm.action.ActivateKeyTable({
            name = "resize_panes",
            -- Ensures the keytable stays active after it handles its
            -- first keypress.
            one_shot = false,
            -- Deactivate the keytable after a timeout.
            timeout_milliseconds = 1000,
        }),
    },
}

config.key_tables = {
    resize_panes = {
        resize_pane("j", "Down"),
        resize_pane("k", "Up"),
        resize_pane("h", "Left"),
        resize_pane("l", "Right"),
    },
}
-- window
config.window_decorations = "RESIZE"

config.window_background_opacity = 0.8
config.macos_window_background_blur = 10
config.inactive_pane_hsb = {
    saturation = 0.5,
    brightness = 0.5,
}
config.window_padding = {
    left = 1.5,
    right = 0,
    top = 1.5,
    bottom = 0,
}

-- and finally, return the configuration to wezterm
return config
