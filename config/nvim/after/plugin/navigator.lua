require('Navigator').setup()

vim.keymap.set({ 'n' }, '<C-J>', vim.cmd.NavigatorDown)
vim.keymap.set({ 'n' }, '<C-K>', vim.cmd.NavigatorUp)
vim.keymap.set({ 'n' }, '<C-L>', vim.cmd.NavigatorRight)
vim.keymap.set({ 'n' }, '<C-H>', vim.cmd.NavigatorLeft)
