local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.cmd("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

vim.cmd([[packadd packer.nvim]])

local startup = require("packer").startup

startup({
  function(use, use_rocks)
    use({ "wbthomason/packer.nvim", opt = true })
    -- checkout https://github.com/echasnovski/mini.nvim

    -- visual
    -- TODO: test https://github.com/marko-cerovac/material.nvim
    use({ "dracula/vim" })
    use({
      "lewis6991/gitsigns.nvim",
      config = function()
        require('gitsigns').setup({
          current_line_blame = true
        })
      end
    })
    use({ "lukas-reineke/indent-blankline.nvim" })
    use({ 'feline-nvim/feline.nvim', branch = '0.5-compat' })
    use({
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup {}
      end
    })

    -- interop
    use({ "christoomey/vim-tmux-navigator" })

    -- motion and fast changes
    use({ "wellle/targets.vim" })
    use({ "chaoren/vim-wordmotion" })
    use({ "FooSoft/vim-argwrap" })
    use({ "tomtom/tcomment_vim" })

    use({ "machakann/vim-sandwich" })
    use({ "AndrewRadev/splitjoin.vim" })

    use {
       'ibhagwan/fzf-lua',
       requires = {
        'kyazdani42/nvim-web-devicons',
        {
          "junegunn/fzf",
          run = './install --bin',
        }
      }
    }

    use({ 'tpope/vim-fugitive' })
    use({ 'hrsh7th/cmp-vsnip' })
    use({ 'hrsh7th/vim-vsnip' })
    use({ 'hrsh7th/nvim-cmp' })

    -- languages
    use({ "editorconfig/editorconfig-vim" })
    use({
      "nvim-treesitter/nvim-treesitter",
      run = function() vim.cmd([[TSUpdate]]) end,
    })
    use({ "nvim-treesitter/nvim-treesitter-textobjects" })
    use({ "nvim-treesitter/nvim-treesitter-context" })
    use({ "mhanberg/elixir.nvim", requires = { "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim" }})

    use_rocks({ "underscore" })
    use_rocks({ "ansicolors" })
  end,
  config = {
    max_jobs = 30,
    display = {
      open_fn = function() return require("packer.util").float({ border = "single" }) end,
    },
  },
})

require("packer.luarocks").setup_paths()

-- set == vim.o
-- let == vim.g
--
vim.g.mapleader = ","
vim.o.termguicolors = true
vim.cmd 'colorscheme dracula'
vim.o.clipboard = "unnamedplus"
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 7
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

-- wait a bit for which-key.nvim
vim.o.timeoutlen = 500

vim.keymap.set('n', '<C-J>', '<C-W><C-J>', {desc = 'Move to pane below'})
vim.keymap.set('n', '<C-K>', '<C-W><C-K>', {desc = 'Move to pane above'})
vim.keymap.set('n', '<C-L>', '<C-W><C-L>', {desc = 'Move to pane to the right'})
vim.keymap.set('n', '<C-H>', '<C-W><C-H>', {desc = 'Move to pane to the left'})

vim.keymap.set('i', 'jk', '<esc>', {desc = 'js as esc'})
vim.keymap.set('i', 'Jk', '<esc>', {desc = 'js as esc'})
vim.keymap.set('i', 'jK', '<esc>', {desc = 'js as esc'})
vim.keymap.set('i', 'JK', '<esc>', {desc = 'js as esc'})

vim.keymap.set('n', '<bar>', ':vsplit<cr>', {desc = ''})
vim.keymap.set('n', '_', ':split<cr>', {desc = ''})

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.undodir = vim.fn.expand("~/.tmp")
vim.o.undofile = true

vim.o.mouse = "a"
vim.o.wildmode = "longest:full,full"
vim.o.autoread = true

vim.keymap.set('n', '<leader>a', ':ArgWrap<cr>', {desc = ''})

vim.api.nvim_create_user_command('Q', 'q', {})
vim.api.nvim_create_user_command('Qall', 'qall', {})
vim.api.nvim_create_user_command('QA', 'qall', {})
vim.api.nvim_create_user_command('E', 'e', {})
vim.api.nvim_create_user_command('W', 'w', {})
vim.api.nvim_create_user_command('Wq', 'wq', {})


vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true

vim.keymap.set('n', '<leader><space>', ':noh<cr>', {silent=true, nowait=true, desc = ''})

vim.keymap.set('c', '<c-n>', '<down>', {silent=true, nowait=true, desc = ''})
vim.keymap.set('c', '<c-p>', '<up>', {silent=true, nowait=true, desc = ''})
vim.keymap.set('c', '<c-h>', '<left>', {silent=true, nowait=true, desc = ''})
vim.keymap.set('c', '<c-l>', '<right>', {silent=true, nowait=true, desc = ''})

vim.o.colorcolumn = "80,120"

vim.keymap.set('n', '0', '^', {silent=true, nowait=true, desc = ''})
vim.keymap.set('n', 'j', 'gj', {silent=true, nowait=true, desc = ''})
vim.keymap.set('n', 'k', 'gk', {silent=true, nowait=true, desc = ''})

vim.keymap.set('n', '<leader>s', ':sort<cr>', {silent=true, nowait=true, desc = ''})

vim.o.cursorline = true

-- vim.keymap.set('n', '<c-p>', ':Files<cr>', {silent=true, nowait=true, desc = ''})
-- vim.keymap.set('n', '<c-i>', ':Rg<cr>', {silent=true, nowait=true, desc = ''})

vim.g.dispatch_handlers = { "job" }


function _G.dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

vim.keymap.set('n', '<c-p>', "<cmd>lua require('fzf-lua').files()<CR>", { noremap = true, silent = true })
vim.keymap.set('n', '<c-i>', "<cmd>lua require('fzf-lua').live_grep()<CR>", { noremap = true, silent = true })

require('feline').setup()

vim.env.FZF_DEFAULT_OPTS = "--reverse"
vim.g.fzf_commands_expect = "enter"
vim.g.fzf_layout = {
  window = {
    width = 0.9,
    height = 0.6,
    yoffset = 0,
    highlight = "Normal",
  },
}
vim.g.fzf_buffers_jump = 1

vim.g.fzf_lsp_width = 70
vim.g.fzf_lsp_layout = {
  window = {
    width = 0.95,
    height = 0.95,
    yoffset = 0,
    highlight = "Normal",
  },
}
vim.g.fzf_lsp_preview_window = { "right:50%" }


-- local cmp = require'cmp'
--
-- cmp.setup({
--   snippet = {
--     -- REQUIRED - you must specify a snippet engine
--     expand = function(args)
--       vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
--       -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
--       -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
--       -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
--     end,
--   },
--   window = {
--     -- completion = cmp.config.window.bordered(),
--     -- documentation = cmp.config.window.bordered(),
--   },
--   mapping = cmp.mapping.preset.insert({
--     ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--     ['<C-f>'] = cmp.mapping.scroll_docs(4),
--     ['<C-Space>'] = cmp.mapping.complete(),
--     ['<C-e>'] = cmp.mapping.abort(),
--     ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
--   }),
--   sources = cmp.config.sources({
--     { name = 'nvim_lsp' },
--     { name = 'vsnip' }, -- For vsnip users.
--     -- { name = 'luasnip' }, -- For luasnip users.
--     -- { name = 'ultisnips' }, -- For ultisnips users.
--     -- { name = 'snippy' }, -- For snippy users.
--   }, {
--     { name = 'buffer' },
--   })
-- })
--
-- -- Set configuration for specific filetype.
-- cmp.setup.filetype('gitcommit', {
--   sources = cmp.config.sources({
--     { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
--   }, {
--     { name = 'buffer' },
--   })
-- })
--
-- -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline('/', {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = {
--     { name = 'buffer' }
--   }
-- })
--
-- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(':', {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = cmp.config.sources({
--     { name = 'path' }
--   }, {
--     { name = 'cmdline' }
--   })
-- })
--
-- -- Setup lspconfig.
-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- -- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
-- --   capabilities = capabilities
-- -- }


elixir = require("elixir")
elixir.setup({
  settings = elixir.settings({
    dialyzerEnabled = false,
    fetchDeps = false,
    enableTestLenses = false,
    suggestSpecs = false,
  })
})

require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all"
  ensure_installed = { "elixir", "lua", "javascript", "typescript" },

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
