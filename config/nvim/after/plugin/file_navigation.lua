require 'lir'.setup {
  show_hidden_files = true,
  float = {
    winblend = 0,
    curdir_window = {
      enable = false,
      highlight_dirname = true,
    },

    -- -- You can define a function that returns a table to be passed as the third
    -- -- argument of nvim_open_win().
    win_opts = function()
      local width = math.floor(vim.o.columns * 0.7)
      local height = math.floor(vim.o.lines * 0.7)
      return {
        border = "rounded",
        width = width,
        height = height,
        -- row = 1,
        -- col = math.floor((vim.o.columns - width) / 2),
      }
    end,
  },
}

require("nvim-tree").setup()

vim.keymap.set('n', '-', require 'lir.float'.toggle, { desc = 'Toggles the in-buffer file navigator' })

vim.keymap.set('n', '<leader>,', ":NvimTreeToggle<cr>", { desc = 'Toggles the side-tree navigator' })
