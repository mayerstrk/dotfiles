-- Pull in the wezterm API
local wezterm = require("wezterm")

-- Create the configuration object
local config = wezterm.config_builder()

-- Set window padding
config.window_padding = {
	left = 1,
	right = 1,
	top = 1,
	bottom = 1,
}
-- Set your preferred color scheme
-- config.color_scheme = "AtelierSulphurpool"
-- config.color_scheme = "Hacktober"
-- config.color_scheme = "Hardcore"
config.color_scheme = "Gotham (terminal.sexy)"
config.color_scheme_dirs = {}
config.colors = {
	brights = {
		"#599cab", -- bright black (fish autosuggestions)
		"#d26939", -- bright red
		"#98d1ce", -- bright green
		"#edb443", -- bright yellow
		"#72a0c1", -- bright blue (bright dirs)
		"#c397d8", -- bright magenta
		"#70c0b1", -- bright cyan
		"#d3ebe9", -- bright white
	},
	ansi = {
		"#0c1014", -- black
		"#c23127", -- red
		"#33859e", -- green
		"#edb443", -- yellow
		"#195466", -- blue (dirs) -> brighter
		"#888ca6", -- magenta
		"#2aa889", -- cyan
		"#98d1ce", -- white
	},
}
-- config.color_scheme = "hund (terminal.sexy)"
--config.color_scheme = "Tokyo Night"
--config.color_scheme = "Rosé Pine (base16)"
--config.color_scheme = "Gruvbox dark, pale (base16)"
-- config.color_scheme = "Gruvbox Material (Gogh)"
-- config.color_scheme = "Gruvbox dark, hard (base16)"
-- config.color_scheme = "Gotham"
-- config.color_scheme = "Royal"
-- config.color_scheme = "Rydgel (terminal.sexy)"
-- config.color_scheme = "Ryuuko"
-- config.color_scheme = "Maia (Gogh)"
-- config.color_scheme = "Material (Gogh)"
-- config.color_scheme = "Adventure"

config.font = wezterm.font("Berkeley Mono")
config.font_size = 15.0

config.window_decorations = "RESIZE"
-- Enable transparency
config.window_background_opacity = 0.78
-- Adjust opacity (0.0 = fully transparent, 1.0 = fully opaque)
config.macos_window_background_blur = 40
-- Key bindings for splitting panes and closing them
config.keys = {
	-- Split vertically (Ctrl+Shift+Enter)
	{
		key = "Enter",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	-- Close the current pane (Ctrl+Shift+W)
	{
		key = "w",
		mods = "CTRL|SHIFT",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	-- Navigate to the left pane (Ctrl+Shift+H)
	{
		key = "h",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	-- Navigate to the right pane (Ctrl+Shift+L)
	{
		key = "l",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	-- Navigate to the upper pane (Ctrl+Shift+K)
	{
		key = "k",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	-- Navigate to the lower pane (Ctrl+Shift+J)
	{
		key = "j",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
}

config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false
config.hide_tab_bar_if_only_one_tab = true

for i = 1, 8 do
	-- CTRL+ALT + number to move to that position
	table.insert(config.keys, {
		key = tostring(i),
		mods = "CTRL|ALT",
		action = wezterm.action.MoveTab(i - 1),
	})
end

-- Return the configuration to wezterm
return config
