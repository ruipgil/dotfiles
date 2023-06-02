local icons = require("ruipgil.icons")
local cmp = require("cmp")
local cmp_types = require("cmp.types.cmp")
local cmp_window = require "cmp.config.window"
local cmp_mapping = require "cmp.config.mapping"
local luasnip = require("luasnip")

local ConfirmBehavior = cmp_types.ConfirmBehavior
local SelectBehavior = cmp_types.SelectBehavior

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

---when inside a snippet, seeks to the nearest luasnip field if possible, and checks if it is jumpable
---@param dir number 1 for forward, -1 for backward; defaults to 1
---@return boolean true if a jumpable luasnip field is found while inside a snippet
local function jumpable(dir)
  local luasnip_ok, luasnip = pcall(require, "luasnip")
  if not luasnip_ok then
    return false
  end

  local win_get_cursor = vim.api.nvim_win_get_cursor
  local get_current_buf = vim.api.nvim_get_current_buf

  ---sets the current buffer's luasnip to the one nearest the cursor
  ---@return boolean true if a node is found, false otherwise
  local function seek_luasnip_cursor_node()
    -- TODO(kylo252): upstream this
    -- for outdated versions of luasnip
    if not luasnip.session.current_nodes then
      return false
    end

    local node = luasnip.session.current_nodes[get_current_buf()]
    if not node then
      return false
    end

    local snippet = node.parent.snippet
    local exit_node = snippet.insert_nodes[0]

    local pos = win_get_cursor(0)
    pos[1] = pos[1] - 1

    -- exit early if we're past the exit node
    if exit_node then
      local exit_pos_end = exit_node.mark:pos_end()
      if (pos[1] > exit_pos_end[1]) or (pos[1] == exit_pos_end[1] and pos[2] > exit_pos_end[2]) then
        snippet:remove_from_jumplist()
        luasnip.session.current_nodes[get_current_buf()] = nil

        return false
      end
    end

    node = snippet.inner_first:jump_into(1, true)
    while node ~= nil and node.next ~= nil and node ~= snippet do
      local n_next = node.next
      local next_pos = n_next and n_next.mark:pos_begin()
      local candidate = n_next ~= snippet and next_pos and (pos[1] < next_pos[1])
          or (pos[1] == next_pos[1] and pos[2] < next_pos[2])

      -- Past unmarked exit node, exit early
      if n_next == nil or n_next == snippet.next then
        snippet:remove_from_jumplist()
        luasnip.session.current_nodes[get_current_buf()] = nil

        return false
      end

      if candidate then
        luasnip.session.current_nodes[get_current_buf()] = node
        return true
      end

      local ok
      ok, node = pcall(node.jump_from, node, 1, true) -- no_move until last stop
      if not ok then
        snippet:remove_from_jumplist()
        luasnip.session.current_nodes[get_current_buf()] = nil

        return false
      end
    end

    -- No candidate, but have an exit node
    if exit_node then
      -- to jump to the exit node, seek to snippet
      luasnip.session.current_nodes[get_current_buf()] = snippet
      return true
    end

    -- No exit node, exit from snippet
    snippet:remove_from_jumplist()
    luasnip.session.current_nodes[get_current_buf()] = nil
    return false
  end

  if dir == -1 then
    return luasnip.in_snippet() and luasnip.jumpable(-1)
  else
    return luasnip.in_snippet() and seek_luasnip_cursor_node() and luasnip.jumpable(1)
  end
end

-- local cmp_mappings = lsp.defaults.cmp_mappings({
--   ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
--   ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
--   ['<S-Tab>'] = cmp.mapping.confirm({ select = true }),
--   ["<C-Space>"] = cmp.mapping.complete(),
-- })

local set_confirm_opts = {
  behavior = ConfirmBehavior.Replace,
  select = false,
}
local set_max_width = 0
local set_formatting = {}
local set_cmdline_options = {
  {
    type = ":",
    sources = {
      { name = "path" },
      { name = "cmdline" },
    },
  },
  {
    type = { "/", "?" },
    sources = {
      { name = "buffer" },
    },
  },
}

set_formatting = {
  fields = { "kind", "abbr", "menu" },
  max_width = set_max_width,
  kind_icons = icons.kind,
  source_names = {
    nvim_lsp = "(LSP)",
    emoji = "(Emoji)",
    path = "(Path)",
    calc = "(Calc)",
    cmp_tabnine = "(Tabnine)",
    vsnip = "(Snippet)",
    luasnip = "(Snippet)",
    buffer = "(Buffer)",
    tmux = "(TMUX)",
    copilot = "(Copilot)",
    treesitter = "(TreeSitter)",
  },
  duplicates = {
    buffer = 1,
    path = 1,
    nvim_lsp = 0,
    luasnip = 1,
  },
  duplicates_default = 0,
  format = function(entry, vim_item)
    local max_width = set_max_width
    if max_width ~= 0 and #vim_item.abbr > max_width then
      vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. icons.ui.Ellipsis
    end

    vim_item.kind = set_formatting.kind_icons[vim_item.kind]

    if entry.source.name == "copilot" then
      vim_item.kind = icons.git.Octoface
      vim_item.kind_hl_group = "CmpItemKindCopilot"
    end

    if entry.source.name == "cmp_tabnine" then
      vim_item.kind = icons.misc.Robot
      vim_item.kind_hl_group = "CmpItemKindTabnine"
    end

    if entry.source.name == "crates" then
      vim_item.kind = icons.misc.Package
      vim_item.kind_hl_group = "CmpItemKindCrate"
    end

    if entry.source.name == "lab.quick_data" then
      vim_item.kind = icons.misc.CircuitBoard
      vim_item.kind_hl_group = "CmpItemKindConstant"
    end

    if entry.source.name == "emoji" then
      vim_item.kind = icons.misc.Smiley
      vim_item.kind_hl_group = "CmpItemKindEmoji"
    end

    vim_item.menu = set_formatting.source_names[entry.source.name]
    vim_item.dup = set_formatting.duplicates[entry.source.name]
        or set_formatting.duplicates_default
    return vim_item
  end,
}

local setup = function()
  cmp.setup({
    active = true,
    enabled = function()
      local buftype = vim.api.nvim_buf_get_option(0, "buftype")
      if buftype == "prompt" then
        return false
      end
      return true
    end,
    confirm_opts = set_confirm_opts,
    completion = {
      ---@usage The minimum length of a word to complete on.
      keyword_length = 1,
    },
    experimental = {
      ghost_text = true,
      native_menu = false,
    },
    formatting = set_formatting,
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    window = {
      completion = cmp_window.bordered(),
      documentation = cmp_window.bordered(),
    },
    sources = {
      {
        name = "copilot",
        -- keyword_length = 0,
        max_item_count = 3,
        trigger_characters = {
          {
            ".",
            ":",
            "(",
            "'",
            '"',
            "[",
            ",",
            "#",
            "*",
            "@",
            "|",
            "=",
            "-",
            "{",
            "/",
            "\\",
            "+",
            "?",
            " ",
            -- "\t",
            -- "\n",
          },
        },
      },
      {
        name = "nvim_lsp",
        -- entry_filter = function(entry, ctx)
        --   local kind = require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]
        --   if kind == "Snippet" and ctx.prev_context.filetype == "java" then
        --     return false
        --   end
        --   if kind == "Text" then
        --     return false
        --   end
        --   return true
        -- end,
      },

      { name = "path" },
      { name = "luasnip" },
      -- { name = "cmp_tabnine" },
      { name = "nvim_lua" },
      {
        name = "buffer",
        option = {
          get_bufnrs = function()
            local bufs = {}
            for _, win in ipairs(vim.api.nvim_list_wins()) do
              bufs[vim.api.nvim_win_get_buf(win)] = true
            end
            return vim.tbl_keys(bufs)
          end
        },
      },
      { name = "calc" },
      { name = "emoji" },
      { name = "treesitter" },
      { name = "crates" },
      { name = "tmux" },
    },
    mapping = cmp_mapping.preset.insert {
      ["<C-k>"] = cmp_mapping(cmp_mapping.select_prev_item(), { "i", "c" }),
      ["<C-j>"] = cmp_mapping(cmp_mapping.select_next_item(), { "i", "c" }),
      ["<Down>"] = cmp_mapping(cmp_mapping.select_next_item { behavior = SelectBehavior.Select }, { "i" }),
      ["<Up>"] = cmp_mapping(cmp_mapping.select_prev_item { behavior = SelectBehavior.Select }, { "i" }),
      ["<C-d>"] = cmp_mapping.scroll_docs(-4),
      ["<C-f>"] = cmp_mapping.scroll_docs(4),
      ["<C-y>"] = cmp_mapping {
        i = cmp_mapping.confirm { behavior = ConfirmBehavior.Replace, select = false },
        c = function(fallback)
          if cmp.visible() then
            cmp.confirm { behavior = ConfirmBehavior.Replace, select = false }
          else
            fallback()
          end
        end,
      },
      ["<Tab>"] = cmp_mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        elseif jumpable(1) then
          luasnip.jump(1)
        elseif has_words_before() then
          cmp.complete()
          -- fallback()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp_mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<C-Space>"] = cmp_mapping.complete(),
      ["<C-e>"] = cmp_mapping.abort(),
      ["<CR>"] = cmp_mapping(function(fallback)
        if cmp.visible() then
          local confirm_opts = vim.deepcopy(set_confirm_opts) -- avoid mutating the original opts below
          local is_insert_mode = function()
            return vim.api.nvim_get_mode().mode:sub(1, 1) == "i"
          end
          if is_insert_mode() then -- prevent overwriting brackets
            confirm_opts.behavior = ConfirmBehavior.Insert
          end
          local entry = cmp.get_selected_entry()
          local is_copilot = entry and entry.source.name == "copilot"
          if is_copilot then
            confirm_opts.behavior = ConfirmBehavior.Replace
            confirm_opts.select = true
          end
          if cmp.confirm(confirm_opts) then
            return -- success, exit early
          end
        end
        fallback() -- if not exited early, always fallback
      end),
    },
    cmdline = {
      enable = false,
      options = set_cmdline_options,
    },
  })

  for _, option in ipairs(set_cmdline_options) do
    cmp.setup.cmdline(option.type, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = option.sources,
    })
  end

  require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
  require("luasnip.loaders.from_lua").lazy_load()
  require("luasnip.loaders.from_snipmate").lazy_load()

  -- If you want insert `(` after select function or method item
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
  )
end

return { setup = setup }