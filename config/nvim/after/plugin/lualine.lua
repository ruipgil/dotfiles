local unsaved_buffer = function()
  if vim.bo.modified then
    return '! *'
  else
    return ''
  end
end

require('lualine').setup {
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'diff', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = { unsaved_buffer },
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  options = {
    icons_enabled = false,
    theme = 'catppuccin',
    component_separators = '|',
    section_separators = '',
  },
}
