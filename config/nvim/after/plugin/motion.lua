require("nvim-autopairs").setup {}
require 'hop'.setup {}
require('Comment').setup()

vim.keymap.set('n', 'gw', ":HopPattern<cr>", { desc = 'Hopping navigation' })
