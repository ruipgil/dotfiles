vim.keymap.set('n', '<leader>gs', vim.cmd.Git)

require('gitsigns').setup({
  current_line_blame = true,
  current_line_blame_opts = {
    delay = 500
  }
})

require('git-conflict').setup()
