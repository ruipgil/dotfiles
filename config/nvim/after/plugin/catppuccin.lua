require('catppuccin').setup {
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
}
