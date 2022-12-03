local wezterm = require 'wezterm'

return {
  -- timeout_milliseconds defaults to 1000 and can be omitted
  -- color_scheme = "tokyonight",
  -- color_scheme = "Catppuccin Latte",
  color_scheme = "Catppuccin Mocha",
  leader = { key = 'Space', mods = 'CTRL' },
  keys = {
    {
      key = 'h',
      mods = 'LEADER',
      action = wezterm.action.ActivatePaneDirection "Left",
    },
    {
      key = 'l',
      mods = 'LEADER',
      action = wezterm.action.ActivatePaneDirection "Right",
    },
    {
      key = 'j',
      mods = 'LEADER',
      action = wezterm.action.ActivatePaneDirection "Down",
    },
    {
      key = 'k',
      mods = 'LEADER',
      action = wezterm.action.ActivatePaneDirection "Up",
    },

    {
      key = '|',
      mods = 'LEADER|SHIFT',
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = '_',
      mods = 'LEADER|SHIFT',
      action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
      key = 'z',
      mods = 'LEADER',
      action = wezterm.action.TogglePaneZoomState,
    },

    { key = '0', mods = 'LEADER', action = wezterm.action.ResetFontSize },
    { key = '+', mods = 'LEADER', action = wezterm.action.IncreaseFontSize },
    { key = '-', mods = 'LEADER', action = wezterm.action.DecreaseFontSize },
  },
  hide_tab_bar_if_only_one_tab = true,
  tab_bar_at_bottom = true,
  use_fancy_tab_bar = false,

  -- Rather than emitting fancy composed characters when alt is pressed, treat the
  -- input more like old school ascii with ALT held down
  send_composed_key_when_left_alt_is_pressed = true,

  -- similarly, don't ask the macOS IME/text services to compose input
  -- use_ime = false,

  term = "xterm-256color",
}
