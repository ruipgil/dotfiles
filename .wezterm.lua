local wezterm = require 'wezterm'
return {
  -- timeout_milliseconds defaults to 1000 and can be omitted
  default_prog = { '/bin/sh' },
  leader = { key = 'Space', mods = 'CTRL', timeout_milliseconds = 1000 },
  keys = {
    {
      key = 'h',
      mods = 'CTRL',
      action = wezterm.action.ActivatePaneDirection "Left",
    },
    {
      key = 'l',
      mods = 'CTRL',
      action = wezterm.action.ActivatePaneDirection "Right",
    },
    {
      key = 'j',
      mods = 'CTRL',
      action = wezterm.action.ActivatePaneDirection "Right",
    },
    {
      key = 'k',
      mods = 'CTRL',
      action = wezterm.action.ActivatePaneDirection "Right",
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
      mods = 'SUPER',
      action = wezterm.action.TogglePaneZoomState,
    },
  },
}
