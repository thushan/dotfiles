local wezterm = require 'wezterm'
local config = {}

config.initial_cols = 180
config.initial_rows = 40
config.scrollback_lines = 9001

-- Font
config.font = wezterm.font("Delugia Mono Nerd Font")
config.font_size = 10
config.window_background_opacity = 0.9
config.default_cursor_style = "BlinkingBar"

-- ===== Colour Scheme (Espresso) =====
config.color_schemes = {
  ["Espresso"] = {
    foreground = "#FFFFFF",
    background = "#323232",
    cursor_bg = "#FFFFFF",
    cursor_fg = "#000000",
    selection_bg = "#FFFFFF",

    ansi = {
      "#353535",
      "#D25252",
      "#A5C261",
      "#FFC66D",
      "#6C99BB",
      "#D197D9",
      "#BED6FF",
      "#EEEEEC",
    },

    brights = {
      "#535353",
      "#F00C0C",
      "#C2E075",
      "#E1E48B",
      "#8AB7D9",
      "#EFB5F7",
      "#DCF4FF",
      "#FFFFFF",
    },
  }
}

config.color_scheme = "OneHalfDark"

config.default_prog = {
  "C:\\Program Files\\Git\\usr\\bin\\bash.exe",
  "-i",
  "-l"
}

config.launch_menu = {
  {
    label = "Bash",
    args = { "C:\\Program Files\\Git\\usr\\bin\\bash.exe", "-i", "-l" }
  },
  {
    label = "PowerShell",
    args = { "pwsh.exe" }
  },
  {
    label = "PowerShell (Admin)",
    args = { "gsudo", "pwsh.exe" }
  },
  {
    label = "CMD",
    args = { "cmd.exe" }
  },
  {
    label = "Python 3.8",
    args = { os.getenv("LOCALAPPDATA") .. "\\Programs\\Python\\Python38-32\\python.exe" }
  }
}

config.keys = {
  { key = "c", mods = "CTRL", action = wezterm.action.CopyTo("Clipboard") },
  { key = "v", mods = "CTRL", action = wezterm.action.PasteFrom("Clipboard") },
  { key = "t", mods = "CTRL|SHIFT", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
  { key = "f", mods = "CTRL|SHIFT", action = wezterm.action.Search({ CaseSensitiveString = "" }) },
  {
    key = "d",
    mods = "ALT|SHIFT",
    action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
}

-- ===== Starting directory =====
-- WT_PROJECTS equivalent (only works if env var exists)
config.default_cwd = os.getenv("WT_PROJECTS")

return config
