local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- Hide window title bar
config.window_decorations = "RESIZE"

-- Terminal backdrop settings
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.window_background_opacity = 1
else
	config.window_background_opacity = 0.95
end
config.macos_window_background_blur = 10

-- Only set WSL domain on Windows/WSL
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.default_domain = "WSL:Ubuntu-24.04"
	config.default_mux_server_domain = "WSL:Ubuntu-24.04"
	config.win32_system_backdrop = "Acrylic"
end

config.default_cwd = wezterm.home_dir

-- Setup initial geometery
config.initial_cols = 120
config.initial_rows = 28
config.line_height = 1.0

-- Font Configurations
config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.font_size = 10.0
else
	config.font_size = 13.0
end

-- Set Color Scheme
config.color_scheme = "Catppuccin Mocha"

-- Enable scroll bar
config.enable_scroll_bar = true

-- SSH connection via spawn instead of SSH domains
config.keys = {
	{
		key = "d",
		mods = "CMD",
		action = wezterm.action.SplitPane({
			direction = "Right",
		}),
	},
	{
		key = "d",
		mods = "CMD|SHIFT",
		action = wezterm.action.SplitPane({
			direction = "Down",
		}),
	},
}

return config
