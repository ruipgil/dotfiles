-- Install packer
local install_path = vim.fn.stdpath 'data' ..
    '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'

  -- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
  local has_plugins, plugins = pcall(require, 'custom.plugins')
  if has_plugins then
    plugins(use)
  end

  -- Appearence
  use { "catppuccin/nvim", as = "catppuccin" }
  use { 'nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' } }
  use {
    'nvim-treesitter/nvim-treesitter-context',
    after = "nvim-treesitter",
    requires = { 'nvim-treesitter/nvim-treesitter' }
  }
  use({
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
    requires = "nvim-treesitter/nvim-treesitter"
  })
  use { "lewis6991/gitsigns.nvim" }
  use { 'nvim-lualine/lualine.nvim', requires = { 'nvim-tree/nvim-web-devicons' } } -- Fancier statusline
  use { 'lukas-reineke/indent-blankline.nvim' }                                     -- Add indentation guides even on blank lines
  use { 'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons', after = "catppuccin" }

  -- LSP
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      {
        'williamboman/mason.nvim',
        run = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' },
    }
  }
  use { "jose-elias-alvarez/null-ls.nvim" }
  use { 'github/copilot.vim' }

  -- File/project navigation
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'ThePrimeagen/harpoon', requires = { 'nvim-lua/plenary.nvim' } }
  use { "bogado/file-line" } -- Allows to :e file/path.extension:file_line
  use { 'nvim-tree/nvim-tree.lua', requires = { 'nvim-tree/nvim-web-devicons' } }

  -- Git
  use { 'tpope/vim-fugitive' }
  use { 'shumphrey/fugitive-gitlab.vim' }
  use { 'tpope/vim-rhubarb' }
  use { "mhanberg/elixir.nvim", requires = { "nvim-lua/plenary.nvim" } }
  use { 'akinsho/git-conflict.nvim', tag = "*" }

  -- In-file/buffer utils
  use { 'tpope/vim-sleuth' }      -- Detect tabstop and shiftwidth automatically
  use { 'numToStr/Comment.nvim' } -- "gc" to comment visual regions/lines
  use { "chaoren/vim-wordmotion" }
  use { "FooSoft/vim-argwrap" }
  use { "windwp/nvim-autopairs" }
  use { 'phaazon/hop.nvim', branch = 'v2' }
  use({ "kylechui/nvim-surround", tag = "*" })

  -- Autocompletion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-path',
      'tzachar/cmp-fuzzy-buffer',
      'tzachar/fuzzy.nvim'
    },
  }

  -- Other
  use { "akinsho/toggleterm.nvim", tag = '*' }

  -- TO TRY:
  -- neodev
  -- fidget
  -- refactoring.nvim
  -- telescope refactoring
  -- nvim-test / vim test

  if is_bootstrap then
    require('packer').sync()
  end
end)

-- Automatically source and re-compile packer whenever you save this init.lua
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])
