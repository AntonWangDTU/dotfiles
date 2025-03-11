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
    t("$$ "), -- Opening display math mode
    i(1), -- Cursor position to enter math
    t("$$"), -- Closing display math mode
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
  s("beg", {
    t({
      "\\documentclass{article}",
      "\\usepackage{stackengine}",
      "\\def\\delequal{\\mathrel{\\ensurestackMath{\\stackon[1pt]{=}{\\scriptstyle\\Delta}}}}",
      "\\usepackage{pgfplots}",
      "\\raggedright",
      "",
      "\\begin{document}",
      "\\today",
      "\\tableofcontents",
      "",
      "\\end{document}",
    }),
  }),
  -- writing powers
  s({ trig = "ru", dscr = "Opløfter", condition = in_mathzone }, {
    i(1), -- Cursor starts inside the superscript (after ^{)
    t("^{"), -- Opening display math mode
    i(2), -- Cursor starts inside the superscript (after ^{)
    t("}"), -- Closing the superscript
  }),
  s({ trig = "rl", dscr = "ned loefter", condition = in_mathzone }, {
    i(1), -- Cursor starts inside the superscript (after ^{)
    t("_{"), -- Opening display math mode
    i(2), -- Cursor position to enter math
    t("}"), -- Closing display math mode
  }),

  -- Lowercase Greek letters (only in math zones)
  s({ trig = "alp", dscr = "Insert α (alpha)", condition = in_mathzone }, { t("\\alpha") }),
  s({ trig = "bet", dscr = "Insert β (beta)", condition = in_mathzone }, { t("\\beta") }),
  s({ trig = "gam", dscr = "Insert γ (gamma)", condition = in_mathzone }, { t("\\gamma") }),
  s({ trig = "del", dscr = "Insert δ (delta)", condition = in_mathzone }, { t("\\delta") }),
  s({ trig = "eps", dscr = "Insert ϵ (epsilon)", condition = in_mathzone }, { t("\\epsilon") }),
  s({ trig = "zet", dscr = "Insert ζ (zeta)", condition = in_mathzone }, { t("\\zeta") }),
  s({ trig = "eta", dscr = "Insert η (eta)", condition = in_mathzone }, { t("\\eta") }),
  s({ trig = "the", dscr = "Insert θ (theta)", condition = in_mathzone }, { t("\\theta") }),
  s({ trig = "iot", dscr = "Insert ι (iota)", condition = in_mathzone }, { t("\\iota") }),
  s({ trig = "kap", dscr = "Insert κ (kappa)", condition = in_mathzone }, { t("\\kappa") }),
  s({ trig = "lam", dscr = "Insert λ (lambda)", condition = in_mathzone }, { t("\\lambda") }),
  s({ trig = "mu", dscr = "Insert μ (mu)", condition = in_mathzone }, { t("\\mu") }),
  s({ trig = "nu", dscr = "Insert ν (nu)", condition = in_mathzone }, { t("\\nu") }),
  s({ trig = "xi", dscr = "Insert ξ (xi)", condition = in_mathzone }, { t("\\xi") }),
  s({ trig = "pi", dscr = "Insert π (pi)", condition = in_mathzone }, { t("\\pi") }),
  s({ trig = "rho", dscr = "Insert ρ (rho)", condition = in_mathzone }, { t("\\rho") }),
  s({ trig = "sig", dscr = "Insert σ (sigma)", condition = in_mathzone }, { t("\\sigma") }),
  s({ trig = "tau", dscr = "Insert τ (tau)", condition = in_mathzone }, { t("\\tau") }),
  s({ trig = "ups", dscr = "Insert υ (upsilon)", condition = in_mathzone }, { t("\\upsilon") }),
  s({ trig = "phi", dscr = "Insert φ (phi)", condition = in_mathzone }, { t("\\phi") }),
  s({ trig = "chi", dscr = "Insert χ (chi)", condition = in_mathzone }, { t("\\chi") }),
  s({ trig = "psi", dscr = "Insert ψ (psi)", condition = in_mathzone }, { t("\\psi") }),
  s({ trig = "ome", dscr = "Insert ω (omega)", condition = in_mathzone }, { t("\\omega") }),

  -- Uppercase Greek letters (only in math zones)
  s({ trig = "Gam", dscr = "Insert Γ (Gamma)", condition = in_mathzone }, { t("\\Gamma") }),
  s({ trig = "Del", dscr = "Insert Δ (Delta)", condition = in_mathzone }, { t("\\Delta") }),
  s({ trig = "The", dscr = "Insert Θ (Theta)", condition = in_mathzone }, { t("\\Theta") }),
  s({ trig = "Lam", dscr = "Insert Λ (Lambda)", condition = in_mathzone }, { t("\\Lambda") }),
  s({ trig = "Xi", dscr = "Insert Ξ (Xi)", condition = in_mathzone }, { t("\\Xi") }),
  s({ trig = "Pi", dscr = "Insert Π (Pi)", condition = in_mathzone }, { t("\\Pi") }),
  s({ trig = "Sig", dscr = "Insert Σ (Sigma)", condition = in_mathzone }, { t("\\Sigma") }),
  s({ trig = "Ups", dscr = "Insert Υ (Upsilon)", condition = in_mathzone }, { t("\\Upsilon") }),
  s({ trig = "Phi", dscr = "Insert Φ (Phi)", condition = in_mathzone }, { t("\\Phi") }),
  s({ trig = "Psi", dscr = "Insert Ψ (Psi)", condition = in_mathzone }, { t("\\Psi") }),
  s({ trig = "Ome", dscr = "Insert Ω (Omega)", condition = in_mathzone }, { t("\\Omega") }),
}
