-- Abbreviations used in this article and the LuaSnip docs
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

-- Include this `in_mathzone` function at the start of a snippets file...
local in_mathzone = function()
  -- The `in_mathzone` function requires the VimTeX plugin
  return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end
-- Then pass the table `{condition = in_mathzone}` to any snippet you want to
-- expand only in math contexts.
--
--
--
return {
  -- Expands 'im' into inline math mode '$...$'
  s({ trig = "im", dscr = "Expands 'im' into inline math mode '$...$' and gives guf" }, {
    t("$ "), -- Opening inline math mode
    i(1), -- Cursor position to enter math
    t("$"), -- Closing inline math mode
  }),
  -- Expands 'dm' into display math mode '\\[ ... \\]'
  s({ trig = "dm", dscr = "Expands 'dm' into display math mode '\\[ ... \\]'" }, {
    t("\\[ "), -- Opening display math mode
    i(1), -- Cursor position to enter math
    t("\\]"), -- Closing display math mode
  }),

  --MATH MODE ACCENTS (ESSENTIALLY EVERYTHING THAT GOES ABOVE)

  s(
    { trig = "til", snippetType = "autosnippet", dscr = "Tilde accent (Transposed operators)", wordTrig = false },
    fmta("\\tilde{<>}", { i(1) }),
    { condition = in_mathzone }
  ),

  s(
    { trig = "dt", snippetType = "autosnippet", dscr = "dot accent (Time derivative)", wordTrig = false },
    fmta("\\dot{<>}", { i(1) }),
    { condition = in_mathzone }
  ),

  -- Priority altered to prevent the triggering of dt.
  s({
    trig = "ddt",
    snippetType = "autosnippet",
    priority = 1001,
    dscr = "double dot accent (double Time derivative)",
    wordTrig = false,
  }, fmta("\\ddot{<>}", { i(1) }), { condition = in_mathzone }),

  s(
    { trig = "bar", snippetType = "autosnippet", dscr = "bar accent", wordTrig = false },
    fmta("\\bar{<>}", { i(1) }),
    { condition = in_mathzone }
  ),

  s(
    { trig = "ha", snippetType = "autosnippet", dscr = "hat accent", wordTrig = false },
    fmta("\\hat{<>}", { i(1) }),
    { condition = in_mathzone }
  ),

  s(
    { trig = "vec", snippetType = "autosnippet", dscr = "Vector", wordTrig = false },
    fmta("\\vec{<>}", { i(1) }),
    { condition = in_mathzone }
  ),
}
