require("ruipgil")

vim.cmd [[
augroup sort_imports
  autocmd!
  autocmd BufWritePre *.ex,*.exs silent! mkview! | silent! g/^\(\(alias\)\@!.\)*$\n\s*alias/+1,/\s*alias.*$\n^\(\(alias\)\@!.\)*$/ sort i
  autocmd BufWritePost *.ex,*.exs silent! loadview
augroup end
]]

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
