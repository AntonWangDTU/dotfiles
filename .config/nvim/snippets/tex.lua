-- Abbreviations used in this article and the LuaSnip docs
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

return {
  -- Combining text and insert nodes to create basic LaTeX commands
  s({ trig = "tt", dscr = "Expands 'tt' into '\texttt{}'" }, {
    t("\\texttt{"), -- remember: backslashes need to be escaped
    i(1),
    t("}"),
  }),
  -- Yes, these jumbles of text nodes and insert nodes get messy fast, and yes,
  -- there is a much better, human-readable solution: ls.fmt, described shortly.
  s({ trig = "ff", dscr = "Expands 'ff' into '\frac{}{}'" }, {
    t("\\frac{"),
    i(1), -- insert node 1
    t("}{"),
    i(2), -- insert node 2
    t("}"),
  }),
  s({ trig = "sign", dscr = "Signs the document" }, {
    t("Anton Wang Strandberg"),
  }),
  s("box", {
    t("\\fbox{"),
    t({ "", "  \\begin{minipage}{\\textwidth}" }),
    t({ "", "    " }),
    i(1, "Your content here"), -- First insert node
    t({ "", "  \\end{minipage}" }),
    t({ "", "}" }),
  }),
}
