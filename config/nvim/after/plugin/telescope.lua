local builtin = require('telescope.builtin')
local telescope_actions = require('telescope.actions')
local telescope = require('telescope')

telescope.setup {
  defaults = {
    layout_strategy = 'horizontal',
    layout_config = { preview_width = 0.4 },
    mappings = {
      i = {
        ["<esc>"] = telescope_actions.close,
        ["<C-u>"] = false,
        ["<C-j>"] = telescope_actions.move_selection_next,
        ["<C-k>"] = telescope_actions.move_selection_previous,
        ["<C-n>"] = telescope_actions.cycle_history_next,
        ["<C-p>"] = telescope_actions.cycle_history_prev,
      },
      n = {
        ["<C-j>"] = telescope_actions.move_selection_next,
        ["<C-k>"] = telescope_actions.move_selection_previous,
      },
    },
  },
  -- extensions = {
  --   fzf = {
  --     fuzzy = true,
  --     override_generic_sorter = true,
  --     override_file_sorter = true,
  --     case_mode = "smart_case",
  --   }
  -- }
}

-- telescope.load_extension('fzf')
telescope.load_extension('harpoon')

local fuzzy_live_grep = function()
  builtin.grep_string({ shorten_path = true, word_match = "-w", only_sort_text = true, search = '' })
end

vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>r', builtin.oldfiles, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>h', builtin.help_tags, {})
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>s', builtin.live_grep, {})
