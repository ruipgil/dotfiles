vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, ',', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set({ 'n' }, '<leader><space>', ':noh<cr>', { silent = true })
vim.keymap.set({ 'n' }, '<bar>', '<C-W>v')
vim.keymap.set({ 'n' }, '_', ':split<cr>', { silent = true })

vim.api.nvim_create_user_command('Q', 'q', {})
vim.api.nvim_create_user_command('Qall', 'qall', {})
vim.api.nvim_create_user_command('QA', 'qall', {})
vim.api.nvim_create_user_command('E', 'e', {})
vim.api.nvim_create_user_command('W', 'w', {})
vim.api.nvim_create_user_command('Wq', 'wq', {})
