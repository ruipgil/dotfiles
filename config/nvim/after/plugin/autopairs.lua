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
