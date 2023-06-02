local wezterm = require('wezterm')
local act = wezterm.action

local function isViProcess(pane)
  -- get_foreground_process_name On Linux, macOS and Windows,
  -- the process can be queried to determine this path. Other operating systems
  -- (notably, FreeBSD and other unix systems) are not currently supported
  return pane:get_foreground_process_name():find('n?vim') ~= nil
  -- return pane:get_title():find("n?vim") ~= nil
end

local function conditionalActivatePane(window, pane, pane_direction, vim_direction)
  if isViProcess(pane) then
    window:perform_action(
    -- This should match the keybinds you set in Neovim.
      act.SendKey({ key = vim_direction, mods = 'CTRL' }),
      pane
    )
  else
    window:perform_action(act.ActivatePaneDirection(pane_direction), pane)
  end
end

wezterm.on('ActivatePaneDirection-right', function(window, pane)
  conditionalActivatePane(window, pane, 'Right', 'l')
end)
wezterm.on('ActivatePaneDirection-left', function(window, pane)
  conditionalActivatePane(window, pane, 'Left', 'h')
end)
wezterm.on('ActivatePaneDirection-up', function(window, pane)
  conditionalActivatePane(window, pane, 'Up', 'k')
end)
wezterm.on('ActivatePaneDirection-down', function(window, pane)
  conditionalActivatePane(window, pane, 'Down', 'j')
end)

return {
  -- timeout_milliseconds defaults to 1000 and can be omitted
  -- color_scheme = "tokyonight",
  -- color_scheme = "Catppuccin Latte",
  color_scheme = "Catppuccin Latte",
  leader = { key = 'Space', mods = 'CTRL' },
  keys = {
    {
      key = 'Space',
      mods = 'LEADER',
      action = wezterm.action.ActivateCopyMode,
    },
    -- {
    --   key = 'h',
    --   mods = 'SUPER',
    --   action = wezterm.action.ActivatePaneDirection "Left",
    -- },
    -- {
    --   key = 'l',
    --   mods = 'SUPER',
    --   action = wezterm.action.ActivatePaneDirection "Right",
    -- },
    -- {
    --   key = 'j',
    --   mods = 'SUPER',
    --   action = wezterm.action.ActivatePaneDirection "Down",
    -- },
    -- {
    --   key = 'k',
    --   mods = 'SUPER',
    --   action = wezterm.action.ActivatePaneDirection "Up",
    -- },

    {
      key = '|',
      mods = 'SUPER|SHIFT',
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = '_',
      mods = 'SUPER|SHIFT',
      action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
      key = 'z',
      mods = 'LEADER',
      action = wezterm.action.TogglePaneZoomState,
    },

    { key = 'x', mods = 'SUPER', action = wezterm.action.CloseCurrentPane { confirm = true } },
    { key = '0', mods = 'SUPER', action = wezterm.action.ResetFontSize },
    { key = '+', mods = 'SUPER', action = wezterm.action.IncreaseFontSize },
    { key = '-', mods = 'SUPER', action = wezterm.action.DecreaseFontSize },
    { key = 'h', mods = 'CTRL',  action = act.EmitEvent('ActivatePaneDirection-left') },
    { key = 'j', mods = 'CTRL',  action = act.EmitEvent('ActivatePaneDirection-down') },
    { key = 'k', mods = 'CTRL',  action = act.EmitEvent('ActivatePaneDirection-up') },
    { key = 'l', mods = 'CTRL',  action = act.EmitEvent('ActivatePaneDirection-right') },
  },
  hide_tab_bar_if_only_one_tab = true,
  tab_bar_at_bottom = true,
  use_fancy_tab_bar = false,
  -- Rather than emitting fancy composed characters when alt is pressed, treat the
  -- input more like old school ascii with ALT held down
  send_composed_key_when_left_alt_is_pressed = true,
  -- similarly, don't ask the macOS IME/text services to compose input
  -- use_ime = false,

  scrollback_lines = 100000,
  term = "xterm-256color",
}