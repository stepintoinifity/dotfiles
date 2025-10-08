-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.initial_rows = 42
config.initial_cols = 172

-- For example, changing the color scheme:
config.color_scheme = "Catppuccin Mocha"
-- config.color_scheme = "Gruvbox Material"

config.enable_tab_bar = false

config.window_decorations = "RESIZE"

-- config.window_background_opacity = 0.77
config.window_background_opacity = 0.77
config.macos_window_background_blur = 22

config.font_size = 17
-- config.font = wezterm.font("JetBrains Mono", { weight = "Regular" })
config.font = wezterm.font("SauceCodePro Nerd Font", { weight = "Regular" })

config.keys = {
	{
		key = "n",
		mods = "SHIFT|CTRL",
		action = wezterm.action.ToggleFullScreen,
	},
}

-- and finally, return the configuration to wezterm
return config
