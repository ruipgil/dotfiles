local lsp = require('lsp-zero').preset('recommended')
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, opts)
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "gr", function() vim.lsp.buf.references({ includeDeclaration = false }) end, opts)
    vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "<leader>dj", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "<leader>dk", function() vim.diagnostic.goto_prev() end, opts)
end

lsp.on_attach(on_attach)
lsp.setup_servers({ 'tsserver', 'eslint', 'elixirls', 'sumneko_lua' })

lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
lspconfig.elixirls.setup({
    capabilities = capabilities,
    settings = {
        elixirLS = {
            dialyzerEnabled = false,
            fetchDeps = false,
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
lsp.format_on_save({
    servers = {
        ['lua_ls'] = { 'lua' },
        ['rust_analyzer'] = { 'rust' },
        ['tsserver'] = { 'typescript' },
        ['eslint'] = { 'javascript' },
    }
})

local cmp_config = require("ruipgil.cmp")
cmp_config.setup()
