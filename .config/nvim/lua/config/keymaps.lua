-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

-- Keybinding setup for LuaSnip
local ls = require("luasnip")

-- Keybinding for jumping to the next snippet placeholder
vim.keymap.set({ "i", "s" }, "<C-k>", function()
  if ls.jumpable(1) then
    ls.jump(1)
  end
end, { silent = true })

-- Keybinding for jumping back to the previous snippet placeholder
vim.keymap.set({ "i", "s" }, "<C-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })
