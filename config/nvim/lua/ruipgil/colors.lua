-- vim.cmd [[colorscheme catppuccin-latte]]

require('indent_blankline').setup {
  char = '┊',
  show_trailing_blankline_indent = false,
}

local unsaved_buffer = function()
  if vim.bo.modified then
    return '! *'
  else
    return ''
  end
end

require('lualine').setup {
  sections = {
    lualine_a = {unsaved_buffer, 'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {unsaved_buffer},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  options = {
    icons_enabled = false,
    theme = 'catppuccin-latte',
    component_separators = '|',
    section_separators = '',
  },
}
