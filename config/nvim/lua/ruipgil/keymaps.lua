vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, ',', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set({ 'n' }, '<leader><space>', ':noh<cr>', { silent = true })
vim.keymap.set({ 'n' }, '<leader>a', ':ArgWrap<cr>', { silent = true })
vim.keymap.set({ 'n' }, '<C-J>', '<C-W><C-J>')
vim.keymap.set({ 'n' }, '<C-K>', '<C-W><C-K>')
vim.keymap.set({ 'n' }, '<C-L>', '<C-W><C-L>')
vim.keymap.set({ 'n' }, '<C-H>', '<C-W><C-H>')
vim.keymap.set({ 'n' }, '<bar>', '<C-W>v')
vim.keymap.set({ 'n' }, '_', ':split<cr>', { silent = true })

vim.api.nvim_create_user_command('Q', 'q', {})
vim.api.nvim_create_user_command('Qall', 'qall', {})
vim.api.nvim_create_user_command('QA', 'qall', {})
vim.api.nvim_create_user_command('E', 'e', {})
vim.api.nvim_create_user_command('W', 'w', {})
vim.api.nvim_create_user_command('Wq', 'wq', {})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
