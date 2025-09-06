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

-- Performance improvements
config.max_fps = 60
config.scrollback_lines = 10000

-- Tab bar configuration
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_max_width = 32

-- Key configurations
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

-- Split pane and navigation
config.keys = {
	-- Split panes (your existing setup)
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
		mods = "LEADER|CTRL",
		action = wezterm.action.SendKey({ key = "a", mods = "CTRL" }),
	},

	-- Pane navigation (your existing setup)
	move_pane("j", "Down"),
	move_pane("k", "Up"),
	move_pane("l", "Right"),
	move_pane("h", "Left"),

	-- Close pane
	{
		key = "w",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},

	-- Resize mode activation
	{
		key = "r",
		mods = "LEADER",
		action = wezterm.action.ActivateKeyTable({
			name = "resize_panes",
			one_shot = false,
			timeout_milliseconds = 1000,
		}),
	},

	-- Tab management (new additions)
	{
		key = "t",
		mods = "LEADER",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "n",
		mods = "LEADER",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		key = "p",
		mods = "LEADER",
		action = wezterm.action.ActivateTabRelative(-1),
	},

	-- Quick tab switching (1-9)
	{ key = "1", mods = "LEADER", action = wezterm.action.ActivateTab(0) },
	{ key = "2", mods = "LEADER", action = wezterm.action.ActivateTab(1) },
	{ key = "3", mods = "LEADER", action = wezterm.action.ActivateTab(2) },
	{ key = "4", mods = "LEADER", action = wezterm.action.ActivateTab(3) },
	{ key = "5", mods = "LEADER", action = wezterm.action.ActivateTab(4) },
	{ key = "6", mods = "LEADER", action = wezterm.action.ActivateTab(5) },
	{ key = "7", mods = "LEADER", action = wezterm.action.ActivateTab(6) },
	{ key = "8", mods = "LEADER", action = wezterm.action.ActivateTab(7) },
	{ key = "9", mods = "LEADER", action = wezterm.action.ActivateTab(8) },

	-- Copy mode
	{
		key = "[",
		mods = "LEADER",
		action = wezterm.action.ActivateCopyMode,
	},
}

config.key_tables = {
	resize_panes = {
		resize_pane("j", "Down"),
		resize_pane("k", "Up"),
		resize_pane("h", "Left"),
		resize_pane("l", "Right"),
		-- Exit resize mode with Escape
		{
			key = "Escape",
			action = "PopKeyTable",
		},
	},
}

-- Window configuration
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.8
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

-- Platform-specific settings
if wezterm.target_triple:find("windows") then
	config.default_prog = { "pwsh.exe", "-NoLogo" }
	config.font_size = 14.0
elseif wezterm.target_triple:find("darwin") then
	config.default_prog = { "/opt/homebrew/bin/fish" }
	config.macos_window_background_blur = 10
	config.font_size = 18.0
end

-- Return the configuration
return config
