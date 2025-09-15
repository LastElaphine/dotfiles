local wezterm = require 'wezterm'

local config = wezterm.config_builder()

-- Hide window title bar
config.window_decorations = 'RESIZE'

-- Terminal backdrop settings
config.window_background_opacity = 0.75
config.win32_system_backdrop = 'Acrylic'
config.macos_window_background_blur = 10

-- Set the default domain to WSL
config.default_domain = 'WSL:Ubuntu-24.04'
config.default_mux_server_domain = 'WSL:Ubuntu-24.04'
config.default_cwd = wezterm.home_dir

-- Setup initial geometery
config.initial_cols = 120
config.initial_rows = 28
config.line_height = 1.0

-- Font Configurations
config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 10.0

-- Set Color Scheme
config.color_scheme = 'rose-pine'

-- Enable scroll bar
config.enable_scroll_bar = true

return config
