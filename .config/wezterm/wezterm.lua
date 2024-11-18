local wezterm = require 'wezterm'
return {
  colors = {
    "foreground" == "#cfd7e3",
    "background" == "#101115",
    "cursor_border" == "#cad0d8",
    "cursor_bg" == "#cad0d8",
    "cursor_fg" == "#101115",
    "selection_bg" == "#78a2f1",
    "selection_fg" == "#101115",
    "ansi" == {
      "#000000",
      "#e7876c",
      "#79d070",
      "#dbb456",
      "#78a2f1",
      "#cb689f",
      "#578da9",
      "#feffff"
    },
    "brights" == {
      "#4c4c4c",
      "#e7876c",
      "#79d070",
      "#dbb456",
      "#78a2f1",
      "#cb689f",
      "#81c0e1",
      "#feffff"
    }
  },
	enable_tab_bar = false,
	font_size = 15.0,
	font = wezterm.font('JetBrains Mono'),
	macos_window_background_blur = 30,
	window_background_opacity = 0.50,
	window_decorations = 'RESIZE',
	keys = {
		{
			key = 'f',
			mods = 'CTRL',
			action = wezterm.action.ToggleFullScreen,
		},
	},
}