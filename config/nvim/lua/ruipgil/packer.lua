-- Install packer
local install_path = vim.fn.stdpath 'data' ..
    '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'

  -- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
  local has_plugins, plugins = pcall(require, 'custom.plugins')
  if has_plugins then
    plugins(use)
  end

  use {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = { 'nvim-lua/plenary.nvim' }
  }
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make'
  }
  use { "catppuccin/nvim", as = "catppuccin" }

  use {
    'nvim-treesitter/nvim-treesitter',
    {run = ':TSUpdate'}
  }
  use { 'nvim-treesitter/nvim-treesitter-context', requires = { 'nvim-treesitter/nvim-treesitter' } }
  use { "lewis6991/gitsigns.nvim" }
  use { 'ThePrimeagen/harpoon', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'tpope/vim-fugitive' }
  use { 'tpope/vim-rhubarb' }
  use { 'tpope/vim-sleuth' } -- Detect tabstop and shiftwidth automatically
  use { ''}

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {
        'williamboman/mason.nvim',
        run = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'L3MON4D3/LuaSnip'},
    }
  }

  use {'numToStr/Comment.nvim'} -- "gc" to comment visual regions/lines
  use {'nvim-lualine/lualine.nvim', requires = { 'nvim-tree/nvim-web-devicons' } } -- Fancier statusline
  use {'lukas-reineke/indent-blankline.nvim'} -- Add indentation guides even on blank lines
  use {"chaoren/vim-wordmotion"}
  use {"FooSoft/vim-argwrap"}
  use {"bogado/file-line"} -- Allows to :e file/path.extension:file_line
  use {"jose-elias-alvarez/null-ls.nvim"}
  use { "windwp/nvim-autopairs" }
  use { 'phaazon/hop.nvim', branch = 'v2' }
  use { "editorconfig/editorconfig-vim" }

  -- use { "AndrewRadev/splitjoin.vim", keys = { "<s-h>", "<s-l>" } }

  use { -- Autocompletion
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

  use { "tamago324/lir.nvim" }

  use { 'akinsho/git-conflict.nvim', tag = "*" }

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
  }

  -- TO TRY:
  -- neodev
  -- fidget
  -- refactoring.nvim
  -- telescope refactoring

  -- use { "vim-test/vim-test" }
  -- use {
  --   "klen/nvim-test",
  --   config = function()
  --     require("nvim-test").setup()
  --
  --     require('nvim-test.runners.elixir'):setup {
  --       command = "busted",
  --       file_pattern = "\\v_spec\\.(ex|exs)$",
  --       find_files = "{name}_test.{exs}",
  --     }
  --   end
  -- }

  if is_bootstrap then
    require('packer').sync()
  end
end)

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

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})
