require("nvim-tree").setup({
  view = {
    centralize_selection = true,
    width = 40,
  },
  actions = {
    open_file = {
      quit_on_open = true,
    }
  }
})
vim.keymap.set('n', '<leader>,', vim.cmd.NvimTreeToggle, { desc = 'Toggles the side-tree navigator' })
