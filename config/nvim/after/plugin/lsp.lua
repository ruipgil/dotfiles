local lsp_zero = require('lsp-zero')
local lspconfig = require('lspconfig')
local null_ls = require('null-ls')
local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')
local cmp_config = require("ruipgil.cmp")
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lsp_signature = require('lsp_signature')

local on_attach = function(client, bufnr)
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


lsp_zero.extend_lspconfig({
    set_lsp_keymaps = false,
    on_attach = on_attach,
    capabilities = capabilities,
})
lsp_zero.format_on_save({
    servers = {
        ['lua_ls'] = { 'lua' },
        ['rust_analyzer'] = { 'rust' },
        ['tsserver'] = { 'typescript' },
        ['eslint'] = { 'javascript' },
        ['null-ls'] = { 'elixir' },
    }
})

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
        local preset = lsp_zero.preset('recommended')
        lspconfig.lua_ls.setup(preset.nvim_lua_ls())
    end,
})

-- Call the language servers you have installed
lspconfig.tsserver.setup({})
lspconfig.eslint.setup({})
lspconfig.rust_analyzer.setup({})
lspconfig.lua_ls.setup(lsp_zero.nvim_lua_ls())
-- lspconfig.elixirls.setup({
--     settings = {
--         elixirLS = {
--             dialyzerEnabled = false,
--             fetchDeps = false,
--             enableTestLenses = true,
--             suggestSpecs = true,
--             dialyzerWarnOpts = {
--                 "no_match",
--                 "no_return",
--                 "no_opaque"
--             }
--         }
--     }
-- })

local elixir = require("elixir")
local elixirls = require("elixir.elixirls")

elixir.setup {
    credo = { enable = false },
    elixirls = {
        enable = false,
        -- settings = elixirls.settings {
        --     dialyzerEnabled = false,
        --     fetchDeps = false,
        --     enableTestLenses = false,
        --     suggestSpecs = false,
        -- },
        -- on_attach = function(client, bufnr)
        --     on_attach(client, bufnr)
        --     -- remove the pipe operator
        --     vim.keymap.set("n", "<leader>fp", ":ElixirFromPipe<cr>", map_opts)
        --     -- add the pipe operator
        --     vim.keymap.set("n", "<leader>tp", ":ElixirToPipe<cr>", map_opts)
        --     vim.keymap.set("v", "<leader>em", ":ElixirExpandMacro<cr>", map_opts)
        --
        --     -- keybinds for fzf-lsp.nvim: https://github.com/gfanto/fzf-lsp.nvim
        --     -- you could also use telescope.nvim: https://github.com/nvim-telescope/telescope.nvim
        --     -- there are also core vim.lsp functions that put the same data in the loclist
        --     -- vim.keymap.set("n", "<space>gr", ":References<cr>", map_opts)
        --     -- vim.keymap.set("n", "<space>g0", ":DocumentSymbols<cr>", map_opts)
        --     -- vim.keymap.set("n", "<space>gW", ":WorkspaceSymbols<cr>", map_opts)
        --     -- vim.keymap.set("n", "<leader>d", ":Diagnostics<cr>", map_opts)
        -- end
    }
}

null_ls.setup({
    debug = true,
    sources = {
        null_ls.builtins.diagnostics.credo,
        null_ls.builtins.formatting.mix
    },
})

cmp_config.setup()

lsp_signature.setup({})
require "fidget".setup {}
