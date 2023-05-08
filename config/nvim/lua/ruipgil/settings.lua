-- vim.cmd [[colorscheme catppuccin-latte]]

vim.o.colorcolumn = "80,120"
vim.o.undodir = vim.fn.expand("~/.tmp")
vim.o.undofile = true
vim.o.relativenumber = true
vim.o.wildmode = "longest:full,full"

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme
vim.o.termguicolors = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,menuone,noselect'

vim.o.clipboard = 'unnamedplus'

vim.o.spell = true
vim.o.spelllang = "en_us"

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
