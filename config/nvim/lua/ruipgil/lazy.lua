local on_attach = function(_client, bufnr)
  local opts = { buffer = bufnr, remap = false }
  local go_to_reference = function()
    require('telescope.builtin').lsp_references({ includeDeclaration = false })
  end
  -- lsp_signature.on_attach(signature_setup, bufnr)

  vim.keymap.set("n", "<leader>cl", function() vim.lsp.codelens.run() end, opts)
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "gr", go_to_reference, opts)
  vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "<leader>dj", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "<leader>dk", function() vim.diagnostic.goto_prev() end, opts)
end

local fzf = function(func)
  return function(...)
    return require("fzf-lua")[func](...)
  end
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
  -- "folke/which-key.nvim",
  -- { "folke/neoconf.nvim", cmd = "Neoconf" },
  -- "folke/neodev.nvim",

  -- Appearence
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      integrations = {
        cmp = true,
        notify = true,
        gitsigns = true,
        markdown = true,
        nvimtree = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        vimwiki = true,
        indent_blankline = {
          enabled = true,
          colored_indent_levels = true,
        },
        barbecue = {
          dim_dirname = true,
          bold_basename = true,
          dim_context = true,
        },
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
        }
      }
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.cmd.colorscheme "catppuccin-latte"
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      context_commentstring = { enable = true, enable_autocmd = false },
      -- playground = {
      --   enable = true,
      --   disable = {},
      --   updatetime = 25,         -- Debounced time for highlighting nodes in the playground from source code
      --   persist_queries = false, -- Whether the query persists across vim sessions
      --   keybindings = {
      --     toggle_query_editor = "o",
      --     toggle_hl_groups = "i",
      --     toggle_injected_languages = "t",
      --     toggle_anonymous_nodes = "a",
      --     toggle_language_display = "I",
      --     focus_language = "f",
      --     unfocus_language = "F",
      --     update = "R",
      --     goto_node = "<cr>",
      --     show_help = "?",
      --   },
      -- },
      textobjects = {
        select = {
          enable = true,
          keymaps = {
            ["ab"] = "@block.outer",
            ["ib"] = "@block.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["if"] = "@function.inner",
            ["af"] = "@function.outer",
          },
        },
        lsp_interop = {
          enable = true,
          floating_preview_opts = { border = "none" },
          peek_definition_code = {
            ["<leader>df"] = "@function.outer",
            ["<leader>dF"] = "@class.outer",
          },
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
      -- "nvim-treesitter/playground",
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("treesitter-context").setup()
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 500
      },
    },
    config = function(_, opts)
      require("gitsigns").setup(opts)
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      -- options = { globalstatus = true, theme = "catppuccin" },
      -- extensions = { "fzf" },
      -- sections = {
      --   lualine_c = { { "filename", path = 1 } },
      --   lualine_x = { "selectioncount", "searchcount", "encoding", "fileformat", "filetype" },
      -- },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
      inactive_sections = {
        -- lualine_a = { unsaved_buffer },
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
      },
      options = {
        icons_enabled = false,
        theme = 'catppuccin',
        component_separators = '|',
        section_separators = '',
      },
    },
    requires = { 'nvim-tree/nvim-web-devicons' },
    config = function(_, opts)
      require('lualine').setup(opts)
    end
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    name = "indent_blankline",
    init = function()
      vim.opt.list = true
    end,
    opts = {
      -- char = "│",
      space_char_blankline = " ",
      show_current_context = true,
      show_current_context_start = true,
      show_trailing_blankline_indent = false,
      filetype_exclude = {
        "terminal",
        "json",
        "lspinfo",
        "packer",
        "checkhealth",
        "help",
        "lazy",
        "",
      },
    },
    config = function(_, opts)
      require('indent_blankline').setup(opts)
    end
  },

  -- LSP
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    lazy = true,
    config = function()
      -- This is where you modify the settings for lsp-zero
      -- Note: autocompletion settings will not take effect

      require('lsp-zero.settings').preset({})
      -- local lsp_zero = require('lsp-zero')
      --
      -- require('lsp-zero.settings').preset({})
      --
      -- lsp_zero.extend_lspconfig({
      --   set_lsp_keymaps = false,
      --   on_attach = on_attach,
      --   -- capabilities = capabilities,
      -- })
      -- lsp_zero.format_on_save({
      --   servers = {
      --     ['lua_ls'] = { 'lua' },
      --     ['rust_analyzer'] = { 'rust' },
      --     ['tsserver'] = { 'typescript' },
      --     ['eslint'] = { 'javascript' },
      --     ['null-ls'] = { 'elixir' },
      --   }
      -- })
    end
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-path',
      'tzachar/cmp-fuzzy-buffer',
      'tzachar/fuzzy.nvim'
    },
    config = function()
      -- Here is where you configure the autocompletion settings.
      -- The arguments for .extend() have the same shape as `manage_nvim_cmp`:
      -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/api-reference.md#manage_nvim_cmp
    end
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = 'LspInfo',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'williamboman/mason-lspconfig.nvim' },
      {
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
    },
    config = function()
      local lsp = require('lsp-zero')
      local lspconfig = require('lspconfig')
      local mason = require('mason')
      local mason_lspconfig = require('mason-lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      lsp.extend_lspconfig({
        set_lsp_keymaps = false,
        on_attach = on_attach,
        capabilities = capabilities,
      })

      lsp.format_on_save({
        servers = {
          ['lua_ls'] = { 'lua' },
          ['rust_analyzer'] = { 'rust' },
          ['tsserver'] = { 'typescript' },
          ['eslint'] = { 'javascript' },
          ['null-ls'] = { 'elixir' },
        }
      })
      lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

      mason.setup()
      mason_lspconfig.setup()
      mason_lspconfig.setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({})
        end,
        ['elixirls'] = function()
          lspconfig.elixirls.setup({
            settings = {
              elixirLS = {
                dialyzerEnabled = false,
                fetchDeps = true,
                enableTestLenses = true,
                suggestSpecs = true,
                dialyzerWarnOpts = {
                  "no_match",
                  "no_return",
                  "no_opaque"
                }
              }
            }
          })
        end,
        ['lua_ls'] = function()
          local preset = lsp.preset('recommended')
          lspconfig.lua_ls.setup(preset.nvim_lua_ls())
        end,
      })
      lsp.setup()

      local cmp_config = require("ruipgil.cmp")
      cmp_config.setup()
    end
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup {
        sources = {
          null_ls.builtins.diagnostics.credo,
          null_ls.builtins.formatting.mix,
          null_ls.builtins.diagnostics.actionlint,
          null_ls.builtins.diagnostics.eslint,
          null_ls.builtins.diagnostics.shellcheck,
          null_ls.builtins.diagnostics.zsh,
          null_ls.builtins.formatting.eslint,
          null_ls.builtins.formatting.pg_format,
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.shfmt,
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.trim_whitespace,
          null_ls.builtins.formatting.trim_newlines,
        },
        on_attach = on_attach
      }
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "j-hui/fidget.nvim",
    config = function()
      require "fidget".setup {}
    end
  },
  {
    "nvim-lua/telescope.nvim",
    cmd = { "Telescope" },
    lazy = false,
    config = function(_, opts)
      local builtin = require('telescope.builtin')
      local telescope_actions = require('telescope.actions')
      local telescope = require('telescope')

      telescope.setup {
        defaults = {
          layout_strategy = 'horizontal',
          layout_config = { preview_width = 0.4 },
          mappings = {
            i = {
              ["<esc>"] = telescope_actions.close,
              ["<C-u>"] = false,
              ["<C-j>"] = telescope_actions.move_selection_next,
              ["<C-k>"] = telescope_actions.move_selection_previous,
              ["<C-n>"] = telescope_actions.cycle_history_next,
              ["<C-p>"] = telescope_actions.cycle_history_prev,
            },
            n = {
              ["<C-j>"] = telescope_actions.move_selection_next,
              ["<C-k>"] = telescope_actions.move_selection_previous,
            },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = false,
            override_file_sorter = false,
            case_mode = "smart_case",
          },
          fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
          }
        }
      }

      -- telescope.load_extension('fzf')
      telescope.load_extension('harpoon')
      -- require('telescope').load_extension('fzy_native')

      local fuzzy_live_grep = function()
        builtin.grep_string({
          shorten_path = true,
          word_match = "-w",
          only_sort_text = true,
          search = ''
        })
      end

      -- vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = "Finds files in current cwd" })
      -- vim.keymap.set('n', '<leader>r', builtin.oldfiles, {})
      -- vim.keymap.set('n', '<leader>b', builtin.buffers, {})
      -- vim.keymap.set('n', '<leader>h', builtin.help_tags, {})
      -- vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = "Finds files in current cwd" })
      -- vim.keymap.set('n', '<leader>s', builtin.live_grep_native,
      -- 	{ desc = "Live search string in current cwd" })
      -- vim.keymap.set('n', '<leader>s', fuzzy_live_grep, {})
    end
  },
  {
    'ThePrimeagen/harpoon',
    requires = { 'nvim-lua/plenary.nvim' },
    opts = {
      menu = {
        width = math.max(math.floor(vim.api.nvim_win_get_width(0) * 0.8), 60),
      }
    },
    config = function(_, opts)
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")

      vim.keymap.set("n", "<leader>m", mark.add_file)
      vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

      vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end)
      vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end)
      vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end)
      vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end)

      require("harpoon").setup(opts)
    end
  },
  { 'bogado/file-line' },
  -- {
  -- 	"nvim-neo-tree/neo-tree.nvim",
  -- 	branch = "v2.x",
  -- 	keys = {
  -- 		{ '<leader>,', ":Neotree<cr>", desc = 'Toggles the side-tree navigator' }
  -- 	},
  -- 	opts = {
  --
  -- 	},
  -- 	config = function(_, opts)
  -- 		require("neo-tree").setup(opts)
  -- 	end,
  -- 	requires = {
  -- 		"nvim-lua/plenary.nvim",
  -- 		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
  -- 		"MunifTanjim/nui.nvim",
  -- 	}
  -- },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      view = {
        centralize_selection = true,
        width = 50,
        float = {
          enable = false,
        },
      },
      actions = {
        open_file = {
          quit_on_open = false,
        }
      }
    },
    keys = {
      { '<leader>,', ":NvimTreeToggle<cr>", desc = 'Toggles the side-tree navigator' }
    },
    config = function(_, opts)
      require("nvim-tree").setup(opts)
    end,
  },
  {
    'numToStr/Navigator.nvim',
    keys = {
      { '<C-J>', vim.cmd.NavigatorDown,  desc = 'Navigates to the pane below' },
      { '<C-K>', vim.cmd.NavigatorUp,    desc = 'Navigates to the pane above' },
      { '<C-L>', vim.cmd.NavigatorRight, desc = 'Navigates to the pane to the right' },
      { '<C-H>', vim.cmd.NavigatorLeft,  desc = 'Navigates to the pane to the left' },
    },
    config = function()
      require('Navigator').setup()
    end
  },
  { "tpope/vim-commentary",    event = { "BufReadPost", "BufNewFile" } },
  { "tpope/vim-dispatch",      event = "VeryLazy" },
  { "tpope/vim-eunuch",        event = "VeryLazy" },
  { "tpope/vim-projectionist", event = { "BufReadPost", "BufNewFile" } },
  { "tpope/vim-repeat",        event = { "BufReadPost", "BufNewFile" } },
  { "tpope/vim-rsi",           event = "VeryLazy" },
  { "tpope/vim-surround",      event = { "BufReadPost", "BufNewFile" } },
  { "tpope/vim-vinegar" },
  {
    'tpope/vim-fugitive',
    event = "VeryLazy",
    keys = {
      {
        '<leader>go',
        ':GBrowse',
        desc = 'Opens the current file on the web front-end of the git hosting provider'
      },
    }
  },
  { 'shumphrey/fugitive-gitlab.vim' },
  { 'farmergreg/vim-lastplace',     event = "VeryLazy" },
  { 'tpope/vim-rhubarb',            event = "VeryLazy" },
  -- { "mhanberg/elixir.nvim", requires = { "nvim-lua/plenary.nvim" } }, TODO
  {
    'akinsho/git-conflict.nvim',
    config = function()
      require('git-conflict').setup()
    end
  },
  -- { 'tpope/vim-sleuth' },      -- Detect tabstop and shiftwidth automatically
  -- {
  -- 	'numToStr/Comment.nvim',
  -- 	config = function()
  -- 		require('Comment').setup()
  -- 	end
  -- }, -- "gc" to comment visual regions/lines
  { "chaoren/vim-wordmotion" },
  {
    "FooSoft/vim-argwrap",
    keys = {
      { '<leader>a', ':ArgWrap<cr>', desc = 'Expand or contract line', silent = true }
    }
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      local npairs = require("nvim-autopairs")
      local Rule = require('nvim-autopairs.rule')

      npairs.setup({
        check_ts = true,
        -- ts_config = {
        --     lua = {'string'},-- it will not add a pair on that treesitter node
        --     javascript = {'template_string'},
        --     java = false,-- don't check treesitter on java
        -- }
      })

      local ts_conds = require('nvim-autopairs.ts-conds')


      -- press % => %% only while inside a comment or string
      npairs.add_rules({
        Rule("%", "%", "lua")
            :with_pair(ts_conds.is_ts_node({ 'string', 'comment' })),
        Rule("$", "$", "lua")
            :with_pair(ts_conds.is_not_ts_node({ 'function' }))
      })

      npairs.add_rules(require('nvim-autopairs.rules.endwise-elixir'))

      -- Add spaces between parentheses https://github.com/windwp/nvim-autopairs/wiki/Custom-rules#add-spaces-between-parentheses
      local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
      npairs.add_rules {
        Rule(' ', ' ')
            :with_pair(function(opts)
              local pair = opts.line:sub(opts.col - 1, opts.col)
              return vim.tbl_contains({
                brackets[1][1] .. brackets[1][2],
                brackets[2][1] .. brackets[2][2],
                brackets[3][1] .. brackets[3][2],
              }, pair)
            end)
      }
      for _, bracket in pairs(brackets) do
        npairs.add_rules {
          Rule(bracket[1] .. ' ', ' ' .. bracket[2])
              :with_pair(function() return false end)
              :with_move(function(opts)
                return opts.prev_char:match('.%' .. bracket[2]) ~= nil
              end)
              :use_key(bracket[2])
        }
      end

      -- Move past commas and semicolons https://github.com/windwp/nvim-autopairs/wiki/Custom-rules#move-past-commas-and-semicolons
      for _, punct in pairs { ",", ";" } do
        npairs.add_rules {
          Rule("", punct)
              :with_move(function(opts) return opts.char == punct end)
              :with_pair(function() return false end)
              :with_del(function() return false end)
              :with_cr(function() return false end)
              :use_key(punct)
        }
      end

      -- Expand pair only on enter key https://github.com/windwp/nvim-autopairs/wiki/Custom-rules#expand-pair-only-on-enter-key
      for _, bracket in pairs { { '(', ')' }, { '[', ']' }, { '{', '}' } } do
        npairs.add_rules {
          Rule(bracket[1], bracket[2])
              :end_wise(function() return true end)
        }
      end

      -- Expand multiple pairs on enter key https://github.com/windwp/nvim-autopairs/wiki/Custom-rules#expand-multiple-pairs-on-enter-key
      local get_closing_for_line = function(line)
        local i = -1
        local clo = ''

        while true do
          i, _ = string.find(line, "[%(%)%{%}%[%]]", i + 1)
          if i == nil then break end
          local ch = string.sub(line, i, i)
          local st = string.sub(clo, 1, 1)

          if ch == '{' then
            clo = '}' .. clo
          elseif ch == '}' then
            if st ~= '}' then return '' end
            clo = string.sub(clo, 2)
          elseif ch == '(' then
            clo = ')' .. clo
          elseif ch == ')' then
            if st ~= ')' then return '' end
            clo = string.sub(clo, 2)
          elseif ch == '[' then
            clo = ']' .. clo
          elseif ch == ']' then
            if st ~= ']' then return '' end
            clo = string.sub(clo, 2)
          end
        end

        return clo
      end

      npairs.remove_rule('(')
      npairs.remove_rule('{')
      npairs.remove_rule('[')

      npairs.add_rule(Rule("[%(%{%[]", "")
        :use_regex(true)
        :replace_endpair(function(opts)
          return get_closing_for_line(opts.line)
        end)
        :end_wise(function(opts)
          -- Do not endwise if there is no closing
          return get_closing_for_line(opts.line) ~= ""
        end))
    end
  },
  {
    'phaazon/hop.nvim',
    branch = 'v2',
    keys = {
      { 'gw', ":HopPattern<cr>", desc = 'Hopping navigation' }
    },
    config = function()
      require('hop').setup()
    end
  },
  {
    "mhanberg/output-panel.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>o", ":OutputPanel<cr>", desc = "Show LSP logs" }
    },
    config = function()
      require("output_panel").setup()
    end
  },
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local actions = require("fzf-lua.actions")
      require("fzf-lua").setup {
        winopts = {
          height = 0.6,           -- window height
          width = 0.9,
          row = 0,                -- window row position (0=top, 1=bottom)
        },
        actions = {
          files = {
            ["default"] = actions.file_edit_or_qf,
            ["ctrl-x"] = actions.file_split,
            ["ctrl-v"] = actions.file_vsplit,
            ["ctrl-t"] = actions.file_tabedit,
            ["alt-q"] = actions.file_sel_to_qf,
            ["alt-l"] = actions.file_sel_to_ll,
          },
        },
        lsp = {
          symbols = {
            symbol_icons = {
              File = "󰈙",
              Module = "",
              Namespace = "󰦮",
              Package = "",
              Class = "󰆧",
              Method = "󰊕",
              Property = "",
              Field = "",
              Constructor = "",
              Enum = "",
              Interface = "",
              Function = "󰊕",
              Variable = "󰀫",
              Constant = "󰏿",
              String = "",
              Number = "󰎠",
              Boolean = "󰨙",
              Array = "󱡠",
              Object = "",
              Key = "󰌋",
              Null = "󰟢",
              EnumMember = "",
              Struct = "󰆼",
              Event = "",
              Operator = "󰆕",
              TypeParameter = "󰗴",
            },
          },
        },
      }
    end,
    keys = {
      { "<c-p>",      fzf("files"),            desc = "Find files" },
      -- { "<space>p", fzf("git_status"), desc = "Find of changes files" },
      -- {
      -- 	"<space>vp",
      -- 	function()
      -- 		fzf("files") { cwd = vim.fn.expand("~/.local/share/nvim/lazy") }
      -- 	end,
      -- 	desc = "Find files of vim plugins",
      -- },
      -- { "<space>df", "<cmd>Files ~/src/<cr>", desc = "Find files in all projects" },
      -- { "<leader>b", fzf("blines"),           desc = "FZF Buffer Lines" },
      --
      -- vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = "Finds files in current cwd" })
      -- vim.keymap.set('n', '<leader>r', builtin.oldfiles, {})
      -- vim.keymap.set('n', '<leader>b', builtin.buffers, {})
      -- vim.keymap.set('n', '<leader>h', builtin.help_tags, {})
      { "<leader>r",  fzf("oldfiles"),         desc = "Open recent files" },
      { "<leader>b",  fzf("buffers"),          desc = "Show current buffers" },
      { "<leader>s",  fzf("live_grep_native"), desc = "Search in project" },
      { "<leader>gs", fzf("git_status"),       desc = "Show git status" },
      -- { "<space>a", ":GlobalProjectSearch<cr>", desc = "Search in all projects" },
    },
  },
  {
    "stevearc/dressing.nvim",
    config = function()
      require("dressing").setup {
        select = {
          backend = {
            -- "telescope",
            "fzf",
          },
        },
      }
    end,
  },
  {
    "folke/noice.nvim",
    enabled = false,
    event = "VeryLazy",
    opts = {
      cmdline = {
        enabled = true,                                        -- disable if you use native command line UI
        view = "cmdline_popup",                                -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
        opts = { buf_options = { filetype = "vim" } },         -- enable syntax highlighting in the cmdline
        icons = {
          ["/"] = { icon = " " },
          ["?"] = { icon = " " },
          [":"] = { icon = ":", firstc = false },
        },
      },
      messages = {
        backend = "mini",
      },
      notify = {
        backend = "mini",
      },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        message = {
          view = "mini",
        },
      },
      views = {
        cmdline_popup = {
          position = {
            row = 1,
            col = "50%",
          },
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            kind = "search_count",
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true },
        },
        {
          filter = { find = "Scanning" },
          opts = { skip = true },
        },
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
    },
  },
  { "mg979/vim-visual-multi", branch = "master", event = { "BufReadPost", "BufNewFile" } },
}, {
  concurrency = 30,
  install = {
    missing = true,
    colorscheme = { "catppuccin-latte" },
  },
  -- performance = {
  -- 	rtp = {
  -- 		-- disable some rtp plugins
  -- 		disabled_plugins = {
  -- 			"gzip",
  -- 			-- "matchit",
  -- 			-- "matchparen",
  -- 			-- "netrwPlugin",
  -- 			"tarPlugin",
  -- 			"tohtml",
  -- 			"tutor",
  -- 			"zipPlugin",
  -- 		},
  -- 	},
  -- },
})