-- Taken from docs
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta

local function get_comment_parts()
  local commentstring = vim.bo.commentstring or "# %s"
  -- Extract the prefix (before %s) and suffix (after %s)
  local prefix, suffix = commentstring:match("^(.-)%%s(.-)$")
  -- Default to empty suffix if it's nil
  return prefix or "", suffix or ""
end

local function get_parts(msg)
  return {
    f(function()
      local prefix, _ = get_comment_parts()
      if msg then
        return prefix .. " " .. msg
      end
      return prefix .. " "
    end),
    i(1),
    f(function()
      local _, suffix = get_comment_parts()
      return " " .. suffix
    end),
  }
end

return {
  s({
    trig = "cmm",
    desc = "add comment; use also Comment.nvim",
    snippetType = "autosnippet",
  }, get_parts()),
  s({
    trig = "tdd",
    desc = "add comment; use also Comment.nvim",
    snippetType = "autosnippet",
  }, get_parts("TODO: ")),
  s({
    trig = "NOO",
    desc = "add comment; use also Comment.nvim",
    snippetType = "autosnippet",
  }, get_parts("NOTE: ")),
}
